package com.ruoyi.drone.service;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.OutputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.time.Duration;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.imageio.ImageIO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.ruoyi.common.config.RuoYiConfig;

@Service
public class QwenAiService
{
    private static final Logger log = LoggerFactory.getLogger(QwenAiService.class);

    private static final String API_URL = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions";
    private static final String API_KEY = "";
    private static final String MODEL = "qwen-vl-max";

    private static Color[] getBoxColors() {
        try {
            return new Color[] {
                new Color(255, 77, 79), new Color(24, 144, 255), new Color(82, 196, 26),
                new Color(250, 140, 22), new Color(114, 46, 209), new Color(19, 194, 194)
            };
        } catch (Throwable t) {
            log.warn("AWT Color init failed, image annotation disabled: {}", t.toString());
            return null;
        }
    }

    private static final Color[] BOX_COLORS = getBoxColors();

    @SuppressWarnings("unchecked")
    public Map<String, Object> recognize(MultipartFile file) throws Exception
    {
        byte[] imageBytes = file.getBytes();
        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
        String mimeType = getMimeType(file.getOriginalFilename());

        String qwenResponse = callQwenApi(base64Image, mimeType);
        Map<String, Object> parsed = parseQwenResponse(qwenResponse);

        String findings = (String) parsed.getOrDefault("findings", "AI 未能识别出明确异常");
        String handling = (String) parsed.getOrDefault("handling", "建议人工复核");
        List<Map<String, Object>> objects = (List<Map<String, Object>>) parsed.getOrDefault("objects", new ArrayList<>());
        List<Map<String, Object>> bboxes = extractBboxes(objects);

        String annotatedImageUrl = null;
        if (BOX_COLORS != null && !bboxes.isEmpty() && imageBytes.length > 0) {
            try {
                byte[] annotatedBytes = drawBoundingBoxes(imageBytes, bboxes, objects);
                annotatedImageUrl = saveAnnotatedImage(annotatedBytes, file.getOriginalFilename());
            } catch (Throwable t) {
                log.warn("Image annotation failed: {}", t.toString());
            }
        }

        Map<String, Object> result = new HashMap<>();
        result.put("findings", findings);
        result.put("handling", handling);
        result.put("bboxes", bboxes);
        result.put("objects", objects);
        result.put("annotatedImageUrl", annotatedImageUrl);
        result.put("fileName", file.getOriginalFilename());
        result.put("fileSize", file.getSize());
        result.put("confidence", parsed.getOrDefault("confidence", 0));
        return result;
    }

    private String callQwenApi(String base64Image, String mimeType) throws Exception
    {
        String dataUri = "data:image/" + mimeType + ";base64," + base64Image;

        Map<String, Object> userContent1 = new HashMap<>();
        userContent1.put("type", "image_url");
        userContent1.put("image_url", Map.of("url", dataUri));

        Map<String, Object> userContent2 = new HashMap<>();
        userContent2.put("type", "text");
        userContent2.put("text", buildPrompt());

        Map<String, Object> userMessage = new HashMap<>();
        userMessage.put("role", "user");
        userMessage.put("content", List.of(userContent1, userContent2));

        Map<String, Object> body = new HashMap<>();
        body.put("model", MODEL);
        body.put("messages", List.of(userMessage));
        body.put("temperature", 0.3);
        body.put("max_tokens", 2000);

        String requestJson = JSON.toJSONString(body);

        HttpClient client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(30))
                .build();

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .header("Authorization", "Bearer " + API_KEY)
                .header("Content-Type", "application/json")
                .timeout(Duration.ofSeconds(60))
                .POST(HttpRequest.BodyPublishers.ofString(requestJson, StandardCharsets.UTF_8))
                .build();

        log.info("Calling Qwen VL API with image size {} bytes", base64Image.length());
        HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
        log.info("Qwen API response status: {}", response.statusCode());

        return response.body();
    }

    private String buildPrompt()
    {
        return "你是一个水域巡防AI助手。请分析这张巡防拍摄图片，识别以下内容并以JSON格式返回（只返回JSON，不要其他文字）：\n" +
            "{\n" +
            "  \"findings\": \"对图片中发现情况的详细描述文字，包括异常类型、位置、数量等\",\n" +
            "  \"handling\": \"针对发现情况的建议处理方案\",\n" +
            "  \"confidence\": 识别置信度(0-100的整数),\n" +
            "  \"objects\": [\n" +
            "    {\"label\": \"目标名称如漂浮物/油污/船只/浮标/倾倒物/藻类/植被破坏/异常水色\", " +
            "\"bbox\": [x, y, width, height]}\n" +
            "  ]\n" +
            "}\n" +
            "坐标bbox为归一化坐标(0-1)，表示目标在图片中的相对位置和大小。如无异常则objects为空数组。";
    }

    private Map<String, Object> parseQwenResponse(String responseBody)
    {
        Map<String, Object> result = new HashMap<>();
        result.put("findings", "AI 未能识别出明确异常");
        result.put("handling", "建议人工复核");
        result.put("confidence", 0);
        result.put("objects", new ArrayList<>());

        try {
            JSONObject root = JSON.parseObject(responseBody);
            JSONArray choices = root.getJSONArray("choices");
            if (choices == null || choices.isEmpty()) return result;

            JSONObject message = choices.getJSONObject(0).getJSONObject("message");
            if (message == null) return result;

            String content = message.getString("content");
            if (content == null || content.isEmpty()) return result;

            content = content.trim();
            if (content.startsWith("```json")) content = content.substring(7);
            if (content.startsWith("```")) content = content.substring(3);
            if (content.endsWith("```")) content = content.substring(0, content.length() - 3);
            content = content.trim();

            JSONObject parsed = JSON.parseObject(content);
            if (parsed.containsKey("findings")) result.put("findings", parsed.getString("findings"));
            if (parsed.containsKey("handling")) result.put("handling", parsed.getString("handling"));
            if (parsed.containsKey("confidence")) result.put("confidence", parsed.getIntValue("confidence"));
            if (parsed.containsKey("objects")) {
                JSONArray objects = parsed.getJSONArray("objects");
                List<Map<String, Object>> objList = new ArrayList<>();
                for (int i = 0; i < objects.size(); i++) {
                    JSONObject obj = objects.getJSONObject(i);
                    Map<String, Object> m = new HashMap<>();
                    m.put("label", obj.getString("label"));
                    JSONArray bbox = obj.getJSONArray("bbox");
                    if (bbox != null && bbox.size() == 4) {
                        m.put("bbox", List.of(bbox.getDouble(0), bbox.getDouble(1), bbox.getDouble(2), bbox.getDouble(3)));
                    }
                    objList.add(m);
                }
                result.put("objects", objList);
            }

            log.info("Qwen AI parsed: findings={}, objects={}", result.get("findings"), result.get("objects"));
        } catch (Exception e) {
            log.error("Failed to parse Qwen response: {}", e.getMessage(), e);
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> extractBboxes(List<Map<String, Object>> objects)
    {
        List<Map<String, Object>> bboxes = new ArrayList<>();
        for (Map<String, Object> obj : objects) {
            Object bboxObj = obj.get("bbox");
            if (bboxObj instanceof List) {
                Map<String, Object> bbox = new HashMap<>();
                bbox.put("label", obj.get("label"));
                bbox.put("bbox", bboxObj);
                bboxes.add(bbox);
            }
        }
        return bboxes;
    }

    @SuppressWarnings("unchecked")
    private byte[] drawBoundingBoxes(byte[] imageBytes, List<Map<String, Object>> bboxes, List<Map<String, Object>> objects) throws Exception
    {
        BufferedImage image = ImageIO.read(new ByteArrayInputStream(imageBytes));
        if (image == null) return imageBytes;

        int width = image.getWidth();
        int height = image.getHeight();
        Graphics2D g = image.createGraphics();
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

        Font font = new Font(Font.SANS_SERIF, Font.BOLD, Math.max(12, Math.min(width, height) / 40));
        g.setFont(font);

        int colorIdx = 0;
        for (Map<String, Object> obj : objects) {
            Object bboxObj = obj.get("bbox");
            if (!(bboxObj instanceof List)) continue;

            List<Number> bbox = (List<Number>) bboxObj;
            if (bbox.size() != 4) continue;

            int x = (int) (bbox.get(0).doubleValue() * width);
            int y = (int) (bbox.get(1).doubleValue() * height);
            int w = (int) (bbox.get(2).doubleValue() * width);
            int h = (int) (bbox.get(3).doubleValue() * height);

            x = Math.max(0, x);
            y = Math.max(0, y);
            w = Math.min(w, width - x);
            h = Math.min(h, height - y);

            Color color = BOX_COLORS[colorIdx % BOX_COLORS.length];
            g.setColor(color);
            g.setStroke(new BasicStroke(Math.max(2, Math.min(width, height) / 200)));
            g.drawRect(x, y, w, h);

            String label = (String) obj.getOrDefault("label", "异常");
            int labelY = y - 4;
            if (labelY < font.getSize()) labelY = y + h + font.getSize();

            g.setColor(new Color(0, 0, 0, 140));
            g.fillRoundRect(x - 1, labelY - font.getSize() + 2, g.getFontMetrics().stringWidth(label) + 10, font.getSize() + 4, 4, 4);
            g.setColor(Color.WHITE);
            g.drawString(label, x + 4, labelY);

            colorIdx++;
        }
        g.dispose();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(image, "jpg", baos);
        return baos.toByteArray();
    }

    private String saveAnnotatedImage(byte[] imageBytes, String originalName) throws Exception
    {
        String uploadDir = RuoYiConfig.getUploadPath();
        File dir = new File(uploadDir + "/ai_annotated");
        if (!dir.exists()) dir.mkdirs();

        String baseName = originalName != null ? originalName.replaceAll("[^a-zA-Z0-9.\\u4e00-\\u9fa5]", "_") : "annotated";
        int dotIdx = baseName.lastIndexOf('.');
        if (dotIdx > 0) baseName = baseName.substring(0, dotIdx);
        String fileName = baseName + "_annotated_" + System.currentTimeMillis() + ".jpg";

        File outFile = new File(dir, fileName);
        try (OutputStream os = Files.newOutputStream(outFile.toPath())) {
            os.write(imageBytes);
        }

        String serverUrl = RuoYiConfig.getServerUrl();
        if (serverUrl != null && !serverUrl.isEmpty()) {
            return serverUrl + "/profile/upload/ai_annotated/" + fileName;
        }
        return "/profile/upload/ai_annotated/" + fileName;
    }

    private String getMimeType(String fileName)
    {
        if (fileName == null) return "jpeg";
        String lower = fileName.toLowerCase();
        if (lower.endsWith(".png")) return "png";
        if (lower.endsWith(".gif")) return "gif";
        if (lower.endsWith(".bmp")) return "bmp";
        if (lower.endsWith(".webp")) return "webp";
        return "jpeg";
    }
}
