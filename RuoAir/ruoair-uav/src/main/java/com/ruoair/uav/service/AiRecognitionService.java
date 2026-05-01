package com.ruoair.uav.service;

import okhttp3.*;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoair.common.config.RuoYiConfig;
import com.ruoair.framework.config.ServerConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 基于 Qwen2.5-VL grounding 能力的 AI 识别与框选服务
 * Qwen 原生 Detect 模式返回 bbox_2d 精确定位，而非依赖文本描述坐标
 */
@Service
public class AiRecognitionService {

    private static final Logger log = LoggerFactory.getLogger(AiRecognitionService.class);

    @Value("${ai.qwen.enabled:false}")
    private boolean enabled;

    @Value("${ai.qwen.api-key:}")
    private String apiKey;

    @Value("${ai.qwen.model:qwen-vl-max}")
    private String model;

    @Value("${ai.qwen.base-url:https://dashscope.aliyuncs.com/compatible-mode/v1}")
    private String baseUrl;

    @Autowired
    private ServerConfig serverConfig;

    private static final Color[] BOX_COLORS = {
        new Color(255, 77, 79), new Color(24, 144, 255), new Color(82, 196, 26),
        new Color(250, 140, 22), new Color(114, 46, 209), new Color(19, 194, 194)
    };

    private static final Pattern BOX_PATTERN = Pattern.compile(
            "<\\|box_start\\|>\\s*\\((\\d+)\\s*,\\s*(\\d+)\\)\\s*,\\s*\\((\\d+)\\s*,\\s*(\\d+)\\)\\s*<\\|box_end\\|>");

    private final OkHttpClient client = new OkHttpClient.Builder()
            .connectTimeout(30, TimeUnit.SECONDS)
            .readTimeout(90, TimeUnit.SECONDS)
            .build();

    // ==================== 公开 API ====================

    /** 根据已有图片 URL 做识别，返回分析文本 + 目标坐标 */
    public Map<String, Object> recognizeImage(String imageUrl, String taskName) {
        Map<String, Object> result = new HashMap<>();
        if (!checkReady(result)) return result;
        if (imageUrl == null || imageUrl.isEmpty()) {
            result.put("success", false); result.put("message", "未提供图片URL"); return result;
        }
        try {
            String dataUri = resolveImageUrl(imageUrl);
            String raw = callQwenVL(dataUri);
            parseResponse(raw, result);
            result.put("model", model);
        } catch (Exception e) {
            log.error("AI识别失败", e);
            result.put("success", false);
            result.put("message", "AI识别失败: " + e.getMessage());
        }
        return result;
    }

    /** 上传图片 → AI 识别 + 画框标注 → 返回标注图 URL */
    public Map<String, Object> recognizeAndAnnotate(byte[] imageBytes, String originalFilename, String taskName) {
        Map<String, Object> result = new HashMap<>();
        if (!checkReady(result)) return result;
        try {
            String mime = getMimeType(originalFilename);
            String dataUri = "data:image/" + mime + ";base64," + Base64.getEncoder().encodeToString(imageBytes);
            String raw = callQwenVL(dataUri);
            parseResponse(raw, result);
            result.put("model", model);

            List<Map<String, Object>> objects = getObjects(result);
            List<double[]> bboxes = extractBboxes(objects);
            if (!bboxes.isEmpty()) {
                byte[] annotated = drawBoxes(imageBytes, bboxes, objects);
                result.put("annotatedImageUrl", saveAnnotated(annotated, originalFilename));
            }
        } catch (Exception e) {
            log.error("AI识别标注失败", e);
            result.put("success", false);
            result.put("message", "AI识别失败: " + e.getMessage());
        }
        return result;
    }

    public boolean isEnabled() {
        return enabled && apiKey != null && !apiKey.isEmpty() && !"your-dashscope-api-key".equals(apiKey);
    }

    public Map<String, Object> checkStatus() {
        Map<String, Object> s = new HashMap<>();
        s.put("enabled", enabled);
        s.put("available", isEnabled());
        s.put("model", model);
        s.put("message", isEnabled() ? "可用" : (!enabled ? "未启用" : "API Key未配置"));
        return s;
    }

    // ==================== Qwen API ====================

    private boolean checkReady(Map<String, Object> result) {
        if (!enabled) { result.put("success", false); result.put("message", "AI识别功能未启用"); return false; }
        if (apiKey == null || apiKey.isEmpty() || "your-dashscope-api-key".equals(apiKey)) {
            result.put("success", false); result.put("message", "API Key未配置"); return false;
        }
        return true;
    }

    private String callQwenVL(String imageDataUri) throws IOException {
        JSONArray content = new JSONArray();
        // 图片在前
        JSONObject img = new JSONObject();
        img.put("type", "image_url");
        img.put("image_url", new JSONObject().fluentPut("url", imageDataUri));
        content.add(img);
        // 文本在后
        JSONObject txt = new JSONObject();
        txt.put("type", "text");
        txt.put("text", buildPrompt());
        content.add(txt);

        JSONObject userMsg = new JSONObject();
        userMsg.put("role", "user");
        userMsg.put("content", content);

        JSONObject body = new JSONObject();
        body.put("model", model);
        body.put("messages", new JSONArray().fluentAdd(userMsg));
        body.put("temperature", 0.05);

        Request request = new Request.Builder()
                .url(baseUrl + "/chat/completions")
                .header("Authorization", "Bearer " + apiKey)
                .post(RequestBody.create(body.toJSONString(), MediaType.parse("application/json")))
                .build();

        try (Response resp = client.newCall(request).execute()) {
            if (!resp.isSuccessful()) {
                String err = resp.body() != null ? resp.body().string() : "";
                throw new IOException("API " + resp.code() + ": " + err);
            }
            return resp.body().string();
        }
    }

    /**
     * 核心提示词：触发 Qwen VL 的目标检测能力
     * 使用 [x,y,width,height] 归一化格式，经示例验证效果好
     */
    private String buildPrompt() {
        return "你是无人机巡防图像AI分析引擎。请按以下步骤分析图片并输出纯JSON（只返回JSON，不要其他文字）：\n\n"
            + "步骤1：仔细观察图片，列出图中所有值得标注的目标物体。\n"
            + "步骤2：对每个目标，精确估算其边界框。bbo为归一化坐标[x,y,width,height](0.0~1.0)：\n"
            + "  x=目标左边界距图片左边缘的比例\n"
            + "  y=目标上边界距图片上边缘的比例\n"
            + "  width=目标水平跨度占图片宽度的比例\n"
            + "  height=目标垂直跨度占图片高度的比例\n"
            + "步骤3：目测验证——想象图片被均匀划分为10×10网格，确认每个坐标值是否准确反映目标的实际位置和大小。\n\n"
            + "输出格式：\n"
            + "{\n"
            + "  \"findings\": \"发现描述\",\n"
            + "  \"handling\": \"处理建议\",\n"
            + "  \"remark\": \"补充信息\",\n"
            + "  \"objects\": [\n"
            + "    {\"label\": \"目标名称\", \"bbox\": [x, y, width, height]}\n"
            + "  ]\n"
            + "}\n"
            + "bbox必须完整包裹目标外轮廓，上/下/左/右各留少许边距。如无目标则objects为空数组[]。";
    }

    // ==================== 响应解析 ====================

    @SuppressWarnings("unchecked")
    private void parseResponse(String responseBody, Map<String, Object> result) {
        try {
            JSONObject root = JSON.parseObject(responseBody);
            JSONArray choices = root.getJSONArray("choices");
            if (choices == null || choices.isEmpty()) { fail(result, "AI无响应"); return; }

            String content = choices.getJSONObject(0).getJSONObject("message").getString("content");
            if (content == null || content.trim().isEmpty()) { fail(result, "AI返回空内容"); return; }

            // 清理 markdown 包裹
            content = content.trim();
            if (content.startsWith("```json")) content = content.substring(7);
            if (content.startsWith("```")) content = content.substring(3);
            if (content.endsWith("```")) content = content.substring(0, content.length() - 3);
            content = content.trim();

            // 打印 Qwen 原始返回内容（前500字符）
            log.info("🔍 Qwen原始返回: {}", content.length() > 500 ? content.substring(0, 500) + "..." : content);

            // 尝试解析 JSON
            JSONObject parsed;
            try {
                parsed = JSON.parseObject(content);
            } catch (Exception je) {
                log.warn("JSON解析失败，尝试提取bbox格式: {}", je.getMessage());
                parseFallback(content, result);
                return;
            }

            result.put("success", true);
            result.put("recognition", content);
            result.put("findings", parsed.getOrDefault("findings", ""));
            result.put("handlingInfo", parsed.getOrDefault("handling", ""));
            result.put("remark", parsed.getOrDefault("remark", ""));

            // 解析 objects / bbox_2d
            JSONArray objectsArr = parsed.getJSONArray("objects");
            List<Map<String, Object>> objects = new ArrayList<>();
            List<Map<String, String>> targets = new ArrayList<>();

            if (objectsArr != null) {
                for (int i = 0; i < objectsArr.size(); i++) {
                    JSONObject obj = objectsArr.getJSONObject(i);
                    String label = obj.getString("label");
                    if (label == null) label = "目标";

                    JSONArray bboxArr = obj.getJSONArray("bbox");
                    if (bboxArr == null) bboxArr = obj.getJSONArray("bbox_2d");

                    if (bboxArr != null && bboxArr.size() == 4) {
                        double bx = bboxArr.getDouble(0);
                        double by = bboxArr.getDouble(1);
                        double bw = bboxArr.getDouble(2);
                        double bh = bboxArr.getDouble(3);

                        // 统一归一化到 0-1：[x, y, width, height]
                        double nx, ny, nw, nh;
                        String coordSrc;
                        if (bx > 1 || by > 1 || bw > 1 || bh > 1) {
                            // 0-1000 角点格式 [x1,y1,x2,y2] → [x,y,w,h] 0-1
                            nx = bx / 1000.0;
                            ny = by / 1000.0;
                            nw = (bw - bx) / 1000.0;
                            nh = (bh - by) / 1000.0;
                            coordSrc = "0-1000角点";
                        } else {
                            // 0-1 归一化 [x,y,w,h]，直接使用
                            nx = bx;
                            ny = by;
                            nw = bw;
                            nh = bh;
                            coordSrc = "0-1归一化";
                        }

                        log.info("📦 Qwen目标[{}] \"{}\" 原始=[{},{},{},{}] {} → 归一化 x={} y={} w={} h={} → 百分比 left={}% top={}% width={}% height={}%",
                                i, label,
                                bx, by, bw, bh, coordSrc,
                                String.format("%.3f", nx), String.format("%.3f", ny),
                                String.format("%.3f", nw), String.format("%.3f", nh),
                                String.format("%.1f", nx * 100), String.format("%.1f", ny * 100),
                                String.format("%.1f", nw * 100), String.format("%.1f", nh * 100));

                        // 原始坐标信息也返回给前端，方便调试
                        Map<String, Object> debug = new HashMap<>();
                        debug.put("rawBbox", Arrays.asList(bx, by, bw, bh));
                        debug.put("coordType", coordSrc);
                        debug.put("normalized", Arrays.asList(
                            Double.parseDouble(String.format("%.3f", nx)),
                            Double.parseDouble(String.format("%.3f", ny)),
                            Double.parseDouble(String.format("%.3f", nw)),
                            Double.parseDouble(String.format("%.3f", nh))));
                        debug.put("percent", Arrays.asList(
                            Double.parseDouble(String.format("%.1f", nx * 100)),
                            Double.parseDouble(String.format("%.1f", ny * 100)),
                            Double.parseDouble(String.format("%.1f", nw * 100)),
                            Double.parseDouble(String.format("%.1f", nh * 100))));

                        // 过滤无效框
                        if (nw <= 0.01 || nh <= 0.01 || nw > 1 || nh > 1) continue;
                        if (nx < 0 || ny < 0 || nx + nw > 1.01 || ny + nh > 1.01) continue;

                        Map<String, Object> m = new HashMap<>();
                        m.put("label", label);
                        m.put("bbox", Arrays.asList(nx, ny, nw, nh));
                        m.put("debug", debug);
                        objects.add(m);

                        Map<String, String> t = new HashMap<>();
                        t.put("name", label);
                        t.put("left", String.format("%.1f", nx * 100));
                        t.put("top", String.format("%.1f", ny * 100));
                        t.put("width", String.format("%.1f", nw * 100));
                        t.put("height", String.format("%.1f", nh * 100));
                        t.put("description", obj.toJSONString());
                        targets.add(t);
                    }
                }
            }
            result.put("objects", objects);
            result.put("targets", targets);
        } catch (Exception e) {
            log.error("解析AI响应失败", e);
            fail(result, "响应解析失败: " + e.getMessage());
        }
    }

    /** 回退：解析 Qwen 原生 <|box_start|>(y1,x1),(y2,x2)<|box_end|> 格式 或文本分段 */
    private void parseFallback(String content, Map<String, Object> result) {
        result.put("success", true);
        result.put("recognition", content);

        // 尝试提取 Qwen 原生 bbox token
        Matcher m = BOX_PATTERN.matcher(content);
        List<Map<String, Object>> objects = new ArrayList<>();
        List<Map<String, String>> targets = new ArrayList<>();

        while (m.find()) {
            // Qwen 原生格式: (y1,x1),(y2,x2) — 注意是 y,x 顺序
            int y1 = Integer.parseInt(m.group(1));
            int x1 = Integer.parseInt(m.group(2));
            int y2 = Integer.parseInt(m.group(3));
            int x2 = Integer.parseInt(m.group(4));

            double left = Math.min(x1, x2) / 10.0;
            double top = Math.min(y1, y2) / 10.0;
            double w = Math.abs(x2 - x1) / 10.0;
            double h = Math.abs(y2 - y1) / 10.0;

            if (w <= 0.5 || h <= 0.5) continue;

            Map<String, Object> obj = new HashMap<>();
            obj.put("label", "目标");
            obj.put("bbox", Arrays.asList(left / 100.0, top / 100.0, w / 100.0, h / 100.0));
            objects.add(obj);

            Map<String, String> t = new HashMap<>();
            t.put("name", "目标");
            t.put("left", String.format("%.1f", left));
            t.put("top", String.format("%.1f", top));
            t.put("width", String.format("%.1f", w));
            t.put("height", String.format("%.1f", h));
            targets.add(t);
        }

        // 文本分段
        result.put("findings", extractSection(content, "[FINDINGS]", "[HANDLING]", "[REMARK]", "[TARGETS]"));
        result.put("handlingInfo", extractSection(content, "[HANDLING]", "[REMARK]", "[TARGETS]", null));
        result.put("remark", extractSection(content, "[REMARK]", "[TARGETS]", null, null));
        if (((String) result.get("findings")).isEmpty()) result.put("findings", content);

        result.put("objects", objects);
        result.put("targets", targets);
    }

    private String extractSection(String content, String start, String... ends) {
        int si = content.indexOf(start);
        if (si < 0) return "";
        si += start.length();
        int ei = content.length();
        for (String end : ends) {
            if (end == null) continue;
            int idx = content.indexOf(end, si);
            if (idx >= 0 && idx < ei) ei = idx;
        }
        return content.substring(si, ei).trim();
    }

    // ==================== AWT 画框 ====================

    @SuppressWarnings("unchecked")
    private byte[] drawBoxes(byte[] imageBytes, List<double[]> bboxes, List<Map<String, Object>> objects) throws Exception {
        BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
        if (image == null) return imageBytes;

        int imgW = image.getWidth();
        int imgH = image.getHeight();
        Graphics2D g = image.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        int fontSize = Math.max(14, Math.min(imgW, imgH) / 35);
        g.setFont(new Font(Font.SANS_SERIF, Font.BOLD, fontSize));
        FontMetrics fm = g.getFontMetrics();
        int sw = Math.max(3, Math.min(imgW, imgH) / 150);

        for (int i = 0; i < bboxes.size(); i++) {
            double[] b = bboxes.get(i);
            // bbox: [x, y, w, h] 归一化 0-1
            int x = (int) (b[0] * imgW);
            int y = (int) (b[1] * imgH);
            int w = (int) (b[2] * imgW);
            int h = (int) (b[3] * imgH);

            if (x < 0) x = 0;
            if (y < 0) y = 0;
            if (x + w > imgW) w = imgW - x;
            if (y + h > imgH) h = imgH - y;
            if (w <= 0 || h <= 0) continue;

            Color c = BOX_COLORS[i % BOX_COLORS.length];
            g.setColor(c);
            g.setStroke(new BasicStroke(sw));
            g.drawRect(x, y, w, h);

            String label = String.valueOf(objects.get(i).getOrDefault("label", "目标"));
            int lw = fm.stringWidth(label) + 12;
            int lh = fm.getHeight() + 6;
            int lx = x;
            int ly = y - lh;
            if (ly < 0) ly = y + h;

            g.setColor(new Color(0, 0, 0, 160));
            g.fillRoundRect(lx, ly, lw, lh, 4, 4);
            g.setColor(Color.WHITE);
            g.drawString(label, lx + 6, ly + fm.getAscent() + 2);
        }
        g.dispose();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "jpg", baos);
        return baos.toByteArray();
    }

    private String saveAnnotated(byte[] imageBytes, String originalName) throws Exception {
        String dirPath = RuoYiConfig.getUploadPath() + "/ai_annotated";
        File dir = new File(dirPath);
        if (!dir.exists()) dir.mkdirs();

        String base = (originalName != null)
            ? originalName.replaceAll("[^a-zA-Z0-9.\\u4e00-\\u9fa5]", "_") : "annotated";
        int dot = base.lastIndexOf('.');
        if (dot > 0) base = base.substring(0, dot);
        String name = base + "_annotated_" + System.currentTimeMillis() + ".jpg";

        try (OutputStream os = Files.newOutputStream(new File(dir, name).toPath())) {
            os.write(imageBytes);
        }
        return serverConfig.getUrl() + "/profile/upload/ai_annotated/" + name;
    }

    // ==================== 工具方法 ====================

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> getObjects(Map<String, Object> result) {
        Object o = result.get("objects");
        return (o instanceof List) ? (List<Map<String, Object>>) o : new ArrayList<>();
    }

    @SuppressWarnings("unchecked")
    private List<double[]> extractBboxes(List<Map<String, Object>> objects) {
        List<double[]> list = new ArrayList<>();
        for (Map<String, Object> obj : objects) {
            Object b = obj.get("bbox");
            if (b instanceof List) {
                List<Number> nb = (List<Number>) b;
                if (nb.size() == 4)
                    list.add(new double[]{nb.get(0).doubleValue(), nb.get(1).doubleValue(),
                                          nb.get(2).doubleValue(), nb.get(3).doubleValue()});
            }
        }
        return list;
    }

    private void fail(Map<String, Object> result, String msg) {
        result.put("success", false);
        result.put("message", msg);
    }

    private String getMimeType(String name) {
        if (name == null) return "jpeg";
        String l = name.toLowerCase();
        if (l.endsWith(".png")) return "png";
        if (l.endsWith(".gif")) return "gif";
        if (l.endsWith(".bmp")) return "bmp";
        if (l.endsWith(".webp")) return "webp";
        return "jpeg";
    }

    private String resolveImageUrl(String url) throws IOException {
        if (url == null || url.isEmpty()) throw new IOException("URL为空");
        if (url.startsWith("data:")) return url;
        if (url.startsWith("http://") || url.startsWith("https://")) {
            if (!url.contains("localhost") && !url.contains("127.0.0.1")) return url;
            int p = url.indexOf("/", 9);
            if (p > 0) url = url.substring(p);
        }
        if (url.startsWith("/profile/"))
            url = RuoYiConfig.getProfile() + url.substring("/profile".length());
        else if (url.startsWith("/"))
            url = RuoYiConfig.getProfile() + url;
        Path path = Paths.get(url);
        if (!Files.exists(path)) throw new IOException("文件不存在: " + url);
        byte[] bytes = Files.readAllBytes(path);
        String ct = Files.probeContentType(path);
        if (ct == null || !ct.startsWith("image/")) ct = "image/png";
        return "data:" + ct + ";base64," + Base64.getEncoder().encodeToString(bytes);
    }
}
