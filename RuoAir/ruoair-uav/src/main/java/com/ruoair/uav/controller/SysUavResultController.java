package com.ruoair.uav.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoair.common.annotation.Log;
import com.ruoair.common.core.controller.BaseController;
import com.ruoair.common.core.domain.AjaxResult;
import com.ruoair.common.enums.BusinessType;
import com.ruoair.uav.domain.SysUavResult;
import com.ruoair.uav.service.ISysUavResultService;
import com.ruoair.uav.service.AiRecognitionService;
import com.ruoair.uav.service.ReportExportService;
import com.ruoair.common.utils.poi.ExcelUtil;
import com.ruoair.common.core.page.TableDataInfo;
import com.ruoair.common.config.RuoYiConfig;
import com.ruoair.common.utils.file.FileUploadUtils;
import com.ruoair.common.utils.file.FileUtils;
import com.ruoair.common.utils.file.MimeTypeUtils;
import com.ruoair.framework.config.ServerConfig;
import org.springframework.web.multipart.MultipartFile;
import java.util.Map;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 巡航结果Controller
 * 
 * @author jiax
 * @date 2026-04-25
 */
@RestController
@RequestMapping("/uav/result")
public class SysUavResultController extends BaseController
{
    @Autowired
    private ISysUavResultService sysUavResultService;

    @Autowired
    private AiRecognitionService aiRecognitionService;

    @Autowired
    private ReportExportService reportExportService;

    @Autowired
    private ServerConfig serverConfig;

    /**
     * 查询巡航结果列表
     */
    @PreAuthorize("@ss.hasPermi('uav:result:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUavResult sysUavResult)
    {
        startPage();
        List<SysUavResult> list = sysUavResultService.selectSysUavResultList(sysUavResult);
        return getDataTable(list);
    }

    /**
     * 导出巡航结果列表
     */
    @PreAuthorize("@ss.hasPermi('uav:result:export')")
    @Log(title = "巡航结果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysUavResult sysUavResult)
    {
        List<SysUavResult> list = sysUavResultService.selectSysUavResultList(sysUavResult);
        ExcelUtil<SysUavResult> util = new ExcelUtil<SysUavResult>(SysUavResult.class);
        util.exportExcel(response, list, "巡航结果数据");
    }

    /**
     * 获取巡航结果详细信息
     */
    @PreAuthorize("@ss.hasPermi('uav:result:query')")
    @GetMapping(value = "/{resultId}")
    public AjaxResult getInfo(@PathVariable("resultId") Long resultId)
    {
        return success(sysUavResultService.selectSysUavResultByResultId(resultId));
    }

    /**
     * 新增巡航结果
     */
    @PreAuthorize("@ss.hasPermi('uav:result:add')")
    @Log(title = "巡航结果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysUavResult sysUavResult)
    {
        return toAjax(sysUavResultService.insertSysUavResult(sysUavResult));
    }

    /**
     * 修改巡航结果
     */
    @PreAuthorize("@ss.hasPermi('uav:result:edit')")
    @Log(title = "巡航结果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysUavResult sysUavResult)
    {
        return toAjax(sysUavResultService.updateSysUavResult(sysUavResult));
    }

    /**
     * 删除巡航结果
     */
    @PreAuthorize("@ss.hasPermi('uav:result:remove')")
    @Log(title = "巡航结果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{resultIds}")
    public AjaxResult remove(@PathVariable Long[] resultIds)
    {
        return toAjax(sysUavResultService.deleteSysUavResultByResultIds(resultIds));
    }

    /**
     * AI识别结果图片
     */
    @PreAuthorize("@ss.hasPermi('uav:result:query')")
    @PostMapping("/recognize/{resultId}")
    public AjaxResult aiRecognize(@PathVariable Long resultId) {
        SysUavResult result = sysUavResultService.selectSysUavResultByResultId(resultId);
        if (result == null) {
            return error("结果记录不存在");
        }
        Map<String, Object> recognitionResult = aiRecognitionService.recognizeImage(
                result.getAiImageUrl(), result.getTaskName());
        return success(recognitionResult);
    }

    /**
     * 检查AI识别接口状态
     */
    @PreAuthorize("@ss.hasPermi('uav:result:query')")
    @GetMapping("/recognize/status")
    public AjaxResult checkAiStatus() {
        return success(aiRecognitionService.checkStatus());
    }

    /**
     * 导出巡防报告PDF
     */
    @PreAuthorize("@ss.hasPermi('uav:result:export')")
    @Log(title = "巡航结果", businessType = BusinessType.EXPORT)
    @GetMapping("/report/{resultId}")
    public void exportReport(@PathVariable Long resultId, HttpServletResponse response) throws IOException {
        SysUavResult result = sysUavResultService.selectSysUavResultByResultId(resultId);
        if (result == null) {
            response.setStatus(404);
            return;
        }
        byte[] pdfBytes = reportExportService.generateReport(result);
        String fileName = URLEncoder.encode("巡防报告_" + result.getResultCode() + ".pdf",
                StandardCharsets.UTF_8);
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.getOutputStream().write(pdfBytes);
        response.getOutputStream().flush();
    }

    /**
     * 上传巡防图片并执行AI识别标注，返回带框选的标注图片URL
     */
    @PreAuthorize("@ss.hasPermi('uav:result:add')")
    @PostMapping("/uploadImage")
    public AjaxResult uploadImage(@RequestParam("file") MultipartFile file) {
        try {
            // 1. 保存原图
            String filePath = RuoYiConfig.getUploadPath() + "/result";
            String fileName = FileUploadUtils.upload(filePath, file, MimeTypeUtils.IMAGE_EXTENSION);
            String url = serverConfig.getUrl() + fileName;

            // 2. AI识别 + 画框标注
            Map<String, Object> aiResult = aiRecognitionService.recognizeAndAnnotate(
                    file.getBytes(), file.getOriginalFilename(), null);

            AjaxResult ajax = AjaxResult.success();
            ajax.put("url", url);
            ajax.put("fileName", fileName);
            ajax.put("originalFilename", file.getOriginalFilename());
            if ((boolean) aiResult.getOrDefault("success", false)) {
                ajax.put("aiSuccess", true);
                ajax.put("findings", aiResult.get("findings"));
                ajax.put("handlingInfo", aiResult.get("handlingInfo"));
                ajax.put("remark", aiResult.get("remark"));
                ajax.put("targets", aiResult.get("targets"));
                String annotatedUrl = (String) aiResult.get("annotatedImageUrl");
                if (annotatedUrl != null && !annotatedUrl.isEmpty()) {
                    ajax.put("annotatedImageUrl", annotatedUrl);
                }
            } else {
                ajax.put("aiSuccess", false);
                ajax.put("aiMessage", aiResult.get("message"));
            }
            return ajax;
        } catch (Exception e) {
            return AjaxResult.error("图片上传失败: " + e.getMessage());
        }
    }

    /**
     * AI自动分析图片（根据URL），返回结构化结果供表单自动填充
     */
    @PreAuthorize("@ss.hasPermi('uav:result:add')")
    @PostMapping("/autoAnalyze")
    public AjaxResult autoAnalyze(@RequestBody Map<String, String> body) {
        String imageUrl = body.get("imageUrl");
        String taskName = body.get("taskName");
        if (imageUrl == null || imageUrl.isEmpty()) {
            return error("图片URL不能为空");
        }
        Map<String, Object> result = aiRecognitionService.recognizeImage(imageUrl, taskName);
        return success(result);
    }
}
