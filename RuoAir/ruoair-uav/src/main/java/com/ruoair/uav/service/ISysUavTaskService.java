package com.ruoair.uav.service;

import java.util.List;
import com.ruoair.uav.domain.SysUavTask;
import org.springframework.transaction.annotation.Transactional;

/**
 * 巡航任务Service接口
 * 
 * @author jiax
 * @date 2026-04-25
 */
public interface ISysUavTaskService 
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
     * 批量删除巡航任务
     * 
     * @param taskIds 需要删除的巡航任务主键集合
     * @return 结果
     */
    public int deleteSysUavTaskByTaskIds(Long[] taskIds);

    /**
     * 删除巡航任务信息
     * 
     * @param taskId 巡航任务主键
     * @return 结果
     */
    public int deleteSysUavTaskByTaskId(Long taskId);
    /**
     * 开始任务
     *
     * @param taskId 任务ID
     */
    public void startTask(Long taskId);

    /**
     * 完成任务（或更新进度）
     *
     * @param taskId 任务ID
     */
    public int completeTask(Long taskId);

    /**
     * 更新任务进度
     *
     * @param taskId 任务ID
     * @param progress 进度(0-100)
     */
    public void updateProgress(Long taskId, Integer progress);

    /**
     * 取消任务
     *
     * @param taskId 任务ID
     * @return 结果
     */
    public int cancelTask(Long taskId);

    public int pauseTask(Long taskId);
}
