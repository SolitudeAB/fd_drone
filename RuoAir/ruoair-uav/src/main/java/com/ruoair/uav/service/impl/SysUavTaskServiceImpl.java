package com.ruoair.uav.service.impl;

import java.util.List;

import com.ruoair.common.exception.ServiceException;
import com.ruoair.common.utils.DateUtils;
import com.ruoair.uav.domain.SysUavEquipment;
import com.ruoair.uav.domain.SysUavResult;
import com.ruoair.uav.domain.SysUavRoute;
import com.ruoair.uav.mapper.SysUavEquipmentMapper;
import com.ruoair.uav.mapper.SysUavResultMapper;
import com.ruoair.uav.mapper.SysUavRouteMapper;
import com.ruoair.uav.service.ISysUavEquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoair.uav.mapper.SysUavTaskMapper;
import com.ruoair.uav.domain.SysUavTask;
import com.ruoair.uav.service.ISysUavTaskService;
import org.springframework.transaction.annotation.Transactional;

/**
 * 巡航任务Service业务层处理
 * 
 * @author jiax
 * @date 2026-04-25
 */
@Service
public class SysUavTaskServiceImpl implements ISysUavTaskService 
{
    @Autowired
    private SysUavTaskMapper sysUavTaskMapper;

    /**
     * 查询巡航任务
     * 
     * @param taskId 巡航任务主键
     * @return 巡航任务
     */
    @Override
    public SysUavTask selectSysUavTaskByTaskId(Long taskId)
    {
        return sysUavTaskMapper.selectSysUavTaskByTaskId(taskId);
    }

    /**
     * 查询巡航任务列表
     * 
     * @param sysUavTask 巡航任务
     * @return 巡航任务
     */
    @Override
    public List<SysUavTask> selectSysUavTaskList(SysUavTask sysUavTask)
    {
        return sysUavTaskMapper.selectSysUavTaskList(sysUavTask);
    }

    /**
     * 新增巡航任务
     * 
     * @param sysUavTask 巡航任务
     * @return 结果
     */
    @Override
    public int insertSysUavTask(SysUavTask sysUavTask)
    {
        sysUavTask.setCreateTime(DateUtils.getNowDate());
        return sysUavTaskMapper.insertSysUavTask(sysUavTask);
    }

    /**
     * 修改巡航任务
     * 
     * @param sysUavTask 巡航任务
     * @return 结果
     */
    @Override
    public int updateSysUavTask(SysUavTask sysUavTask)
    {
        sysUavTask.setUpdateTime(DateUtils.getNowDate());
        return sysUavTaskMapper.updateSysUavTask(sysUavTask);
    }

    /**
     * 批量删除巡航任务
     * 
     * @param taskIds 需要删除的巡航任务主键
     * @return 结果
     */
    @Override
    public int deleteSysUavTaskByTaskIds(Long[] taskIds)
    {
        return sysUavTaskMapper.deleteSysUavTaskByTaskIds(taskIds);
    }

    /**
     * 删除巡航任务信息
     * 
     * @param taskId 巡航任务主键
     * @return 结果
     */
    @Override
    public int deleteSysUavTaskByTaskId(Long taskId)
    {
        return sysUavTaskMapper.deleteSysUavTaskByTaskId(taskId);
    }

    @Autowired
    private SysUavEquipmentMapper sysUavEquipmentMapper;

    @Autowired
    private SysUavRouteMapper sysUavRouteMapper;

    @Autowired
    private SysUavResultMapper sysUavResultMapper;

    @Autowired
    private ISysUavEquipmentService sysUavEquipmentService;

    /**
     * 开始任务
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void startTask(Long taskId) {
        // 1. 查询任务信息
        SysUavTask task = sysUavTaskMapper.selectSysUavTaskByTaskId(taskId);
        if (task == null) {
            throw new ServiceException("任务不存在！");
        }

        // 2. 检查任务状态（只有待开始的任务才能启动）
        if (!"0".equals(task.getTaskStatus())) {
            throw new ServiceException("任务状态不是【待开始】，无法启动！");
        }

        // 3. 校验设备是否可用
        sysUavEquipmentService.checkEquipmentAvailable(task.getEquipmentId());

        // 4. 更新设备状态为"任务中"(3)
        sysUavEquipmentService.updateEquipmentStatus(task.getEquipmentId(), "3");

        // 5. 更新任务信息
        task.setTaskStatus("1"); // 1=执行中
        task.setStartTime(DateUtils.getNowDate()); // actualStartTime
        task.setProgress(0); // 初始进度0
        task.setUpdateTime(DateUtils.getNowDate());

        sysUavTaskMapper.updateSysUavTask(task);
    }

    /**
     * 完成任务（自动归档与结果生成）
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int completeTask(Long taskId) {
        // 1. 获取任务详情
        SysUavTask task = sysUavTaskMapper.selectSysUavTaskByTaskId(taskId);
        if (task == null) {
            throw new ServiceException("任务不存在！");
        }

        // 2. 检查任务状态（只有执行中的任务才能完成）
        if (!"1".equals(task.getTaskStatus())) {
            throw new ServiceException("任务状态不是【执行中】，无法完成！");
        }

        // 3. 获取设备和航线信息（用于快照）
        SysUavEquipment equipment = sysUavEquipmentMapper.selectSysUavEquipmentByEquipmentId(task.getEquipmentId());
        SysUavRoute route = sysUavRouteMapper.selectSysUavRouteByRouteId(task.getRouteId());

        // 4. 结束任务：状态改为"已完成(2)"，进度拉满
        task.setTaskStatus("2");
        task.setEndTime(DateUtils.getNowDate());
        task.setProgress(100);
        task.setUpdateTime(DateUtils.getNowDate());
        int taskResult = sysUavTaskMapper.updateSysUavTask(task);

        // 5. 释放设备：状态恢复为"空闲(0)"
        if (equipment != null) {
            equipment.setStatus("0");
            equipment.setUpdateTime(DateUtils.getNowDate());
            sysUavEquipmentMapper.updateSysUavEquipment(equipment);
        }

        // 6. 自动插入结果记录（数据快照）
        SysUavResult result = new SysUavResult();
        result.setResultCode("RES-" + System.currentTimeMillis());
        result.setTaskId(taskId);
        result.setTaskName(task.getTaskName());           // 冗余存储，防止原任务删除后丢失信息
        result.setEquipmentName(equipment != null ? equipment.getEquipmentName() : "");
        result.setRouteName(route != null ? route.getRouteName() : "");
        result.setExecutor(task.getExecutor());
        result.setOverview("本次巡航任务正常完成。");
        result.setCreateTime(DateUtils.getNowDate());

        sysUavResultMapper.insertSysUavResult(result);

        return taskResult;
    }


    /**
     * 更新任务进度
     */
    @Override
    public void updateProgress(Long taskId, Integer progress) {
        SysUavTask task = new SysUavTask();
        task.setTaskId(taskId);
        task.setProgress(progress);
        task.setUpdateTime(DateUtils.getNowDate());
        sysUavTaskMapper.updateSysUavTask(task);
    }

    /**
     * 生成结果快照（写入 sys_uav_result 表）
     */
    private void generateResultSnapshot(SysUavTask task, String handlingInfo, String aiImageUrl) {
        // 查询设备名称
        SysUavEquipment equipment = sysUavEquipmentMapper.selectSysUavEquipmentByEquipmentId(task.getEquipmentId());
        String equipmentName = equipment != null ? equipment.getEquipmentName() : "";

        // 查询航线名称（需要注入 SysUavRouteMapper）
        // SysUavRoute route = sysUavRouteMapper.selectSysUavRouteByRouteId(task.getRouteId());
        // String routeName = route != null ? route.getRouteName() : "";
        String routeName = ""; // 暂时为空，等 RouteMapper 注入后可获取

        // 创建结果记录
        SysUavResult result = new SysUavResult();
        result.setTaskId(task.getTaskId());
        result.setResultCode("RES_" + System.currentTimeMillis());
        result.setTaskName(task.getTaskName());
        result.setEquipmentName(equipmentName);
        result.setRouteName(routeName);
        result.setExecutor(task.getExecutor());
        result.setHandlingInfo(handlingInfo);
        result.setAiImageUrl(aiImageUrl);
        result.setCreateTime(DateUtils.getNowDate());

        sysUavResultMapper.insertSysUavResult(result);
    }
}
