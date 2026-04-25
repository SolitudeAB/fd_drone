package com.ruoair.uav.controller;

import com.ruoair.common.core.controller.BaseController;
import com.ruoair.common.core.domain.AjaxResult;
import com.ruoair.uav.service.ISysUavDashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 无人机首页数据大盘 控制层
 */
@RestController
@RequestMapping("/uav/dashboard")
public class SysUavDashboardController extends BaseController {

    @Autowired
    private ISysUavDashboardService dashboardService;

    /**
     * 获取大盘所有统计数据
     */
    @GetMapping("/stats")
    public AjaxResult getStats() {
        // 调用 Service 获取聚合好的数据
        Map<String, Object> data = dashboardService.getDashboardData();
        return AjaxResult.success(data);
    }
}