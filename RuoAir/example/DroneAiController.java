package com.ruoyi.web.controller.drone;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.drone.domain.PatrolResult;
import com.ruoyi.drone.service.PatrolResultService;
import com.ruoyi.drone.service.QwenAiService;

@RestController
@RequestMapping("/drone/result/ai")
public class DroneAiController
{
    @Autowired
    private PatrolResultService patrolResultService;

    @Autowired
    private QwenAiService qwenAiService;

    @PreAuthorize("@ss.hasPermi('drone:result:edit')")
    @PostMapping("/upload")
    public AjaxResult aiRecognize(@RequestParam("file") MultipartFile file, @RequestParam("resultId") Long resultId)
    {
        if (file.isEmpty()) {
            return AjaxResult.error("上传文件不能为空");
        }

        PatrolResult result = patrolResultService.selectPatrolResultByResultId(resultId);
        if (result == null) {
            return AjaxResult.error("结果记录不存在");
        }

        try {
            long startTime = System.currentTimeMillis();
            Map<String, Object> aiResult = qwenAiService.recognize(file);
            long endTime = System.currentTimeMillis();

            aiResult.put("processTime", endTime - startTime);

            String annotatedImageUrl = (String) aiResult.get("annotatedImageUrl");
            if (annotatedImageUrl != null && !annotatedImageUrl.isEmpty()) {
                result.setAiImageUrl(annotatedImageUrl);
                patrolResultService.updatePatrolResult(result);
            }

            return AjaxResult.success(aiResult);
        } catch (Exception e) {
            return AjaxResult.error("AI识别失败: " + e.getMessage());
        }
    }

    @PreAuthorize("@ss.hasPermi('drone:result:edit')")
    @PostMapping("/apply/{resultId}")
    public AjaxResult applyAiResult(@PathVariable Long resultId,
                                     @RequestParam("findings") String findings,
                                     @RequestParam("handling") String handling,
                                     @RequestParam(value = "imageUrl", required = false) String imageUrl)
    {
        PatrolResult result = patrolResultService.selectPatrolResultByResultId(resultId);
        if (result == null) {
            return AjaxResult.error("结果记录不存在");
        }

        result.setFindings(findings);
        result.setHandling(handling);
        if (imageUrl != null && !imageUrl.isEmpty()) {
            result.setAiImageUrl(imageUrl);
        }
        patrolResultService.updatePatrolResult(result);
        return AjaxResult.success("AI识别结果已应用");
    }
}
