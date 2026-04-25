package com.ruoair.uav.mapper;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

/**
 * 无人机首页数据大盘 Mapper 接口
 */
@Mapper
public interface SysUavDashboardMapper {

    // 统计设备总数
    int countEquipment();

    // 统计航线总数
    int countRoute();

    // 统计任务总数
    int countTask();

    // 统计结果总数
    int countResult();

    // 按照状态分组统计设备 (用于饼图)
    List<Map<String, Object>> selectEquipmentStatusGroup();

    // 统计近7天每天的任务执行数量 (用于折线图)
    List<Map<String, Object>> selectTaskTrendLast7Days();
}