package com.ruoair.uav.service;

import java.util.Map;

/**
 * 无人机首页数据大盘 服务层接口
 */
public interface ISysUavDashboardService {

    /**
     * 获取首页数据大盘的综合统计数据
     * @return 包含各项总数及图表数据的 Map
     */
    Map<String, Object> getDashboardData();
}