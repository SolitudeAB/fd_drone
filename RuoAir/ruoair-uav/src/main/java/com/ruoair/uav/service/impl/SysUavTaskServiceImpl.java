package com.ruoair.uav.service.impl;

import java.util.List;
import com.ruoair.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoair.uav.mapper.SysUavTaskMapper;
import com.ruoair.uav.domain.SysUavTask;
import com.ruoair.uav.service.ISysUavTaskService;

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
}
