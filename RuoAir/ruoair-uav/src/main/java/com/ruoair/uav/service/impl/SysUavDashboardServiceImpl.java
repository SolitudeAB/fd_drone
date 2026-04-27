package com.ruoair.uav.service.impl;

import com.ruoair.uav.mapper.SysUavDashboardMapper;
import com.ruoair.uav.service.ISysUavDashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.List;

/**
 * 无人机首页数据大盘 服务层实现
 */
@Service
public class SysUavDashboardServiceImpl implements ISysUavDashboardService {

    @Autowired
    private SysUavDashboardMapper dashboardMapper;

    @Override
    public Map<String, Object> getDashboardData() {
        Map<String, Object> result = new HashMap<>();

        // 1. 顶部四大基础数据统计
        result.put("equipmentTotal", dashboardMapper.countEquipment());
        result.put("routeTotal", dashboardMapper.countRoute());
        result.put("taskTotal", dashboardMapper.countTask());
        result.put("resultTotal", dashboardMapper.countResult());

        // 2. 左侧饼图：查询设备状态分布 (返回格式: [{name: '正常', value: 10}, ...])
        List<Map<String, Object>> equipmentStatusData = dashboardMapper.selectEquipmentStatusGroup();
        for (Map<String, Object> item : equipmentStatusData)
        {
            Object statusCode = item.get("name");
            if (statusCode == null)
            {
                continue;
            }
            item.put("name", mapStatusLabel(String.valueOf(statusCode)));
        }
        result.put("pieData", equipmentStatusData);

        // 3. 右侧折线图：查询近七天任务趋势
        // 3. 右侧折线图：查询近七天任务趋势
        List<Map<String, Object>> taskTrendData = dashboardMapper.selectTaskTrendLast7Days();
        result.put("lineData", taskTrendData);

        // 4. 今日待执行任务数
        result.put("pendingToday", dashboardMapper.countPendingToday());

        // 5. 本周完成任务数
        result.put("completedThisWeek", dashboardMapper.countCompletedThisWeek());

        return result;
    }

    private String mapStatusLabel(String statusCode)
    {
        if ("0".equals(statusCode))
        {
            return "正常";
        }
        if ("1".equals(statusCode))
        {
            return "维修中";
        }
        if ("2".equals(statusCode))
        {
            return "已报废";
        }
        if ("3".equals(statusCode))
        {
            return "任务中";
        }
        return statusCode;
    }
}
