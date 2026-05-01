package com.ruoair.uav.mapper;

import java.util.List;
import com.ruoair.uav.domain.SysUavTask;

/**
 * 巡航任务Mapper接口
 * 
 * @author jiax
 * @date 2026-04-25
 */
public interface SysUavTaskMapper 
{
    /**
     * 查询巡航任务
     * 
     * @param taskId 巡航任务主键
     * @return 巡航任务
     */
    public SysUavTask selectSysUavTaskByTaskId(Long taskId);

    /**
     * 查询巡航任务列表
     * 
     * @param sysUavTask 巡航任务
     * @return 巡航任务集合
     */
    public List<SysUavTask> selectSysUavTaskList(SysUavTask sysUavTask);

    /**
     * 新增巡航任务
     * 
     * @param sysUavTask 巡航任务
     * @return 结果
     */
    public int insertSysUavTask(SysUavTask sysUavTask);

    /**
     * 修改巡航任务
     * 
     * @param sysUavTask 巡航任务
     * @return 结果
     */
    public int updateSysUavTask(SysUavTask sysUavTask);

    /**
     * 删除巡航任务
     * 
     * @param taskId 巡航任务主键
     * @return 结果
     */
    public int deleteSysUavTaskByTaskId(Long taskId);

    /**
     * 批量删除巡航任务
     * 
     * @param taskIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysUavTaskByTaskIds(Long[] taskIds);
}
