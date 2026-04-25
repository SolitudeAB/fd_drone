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
        result.put("pieData", equipmentStatusData);

        // 3. 右侧折线图：查询近七天任务趋势
        // 获取近7天的日期列表和对应的任务数
        List<Map<String, Object>> taskTrendData = dashboardMapper.selectTaskTrendLast7Days();
        result.put("lineData", taskTrendData);

        return result;
    }
}