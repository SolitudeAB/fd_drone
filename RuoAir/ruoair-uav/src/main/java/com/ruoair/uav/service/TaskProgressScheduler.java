package com.ruoair.uav.service;

import com.ruoair.uav.domain.SysUavTask;
import com.ruoair.uav.mapper.SysUavTaskMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class TaskProgressScheduler {

    private static final Logger log = LoggerFactory.getLogger(TaskProgressScheduler.class);

    @Autowired
    private SysUavTaskMapper sysUavTaskMapper;

    @Autowired
    private ISysUavTaskService sysUavTaskService;

    @Scheduled(fixedRate = 60000)
    public void autoIncrementProgress() {
        try {
            SysUavTask query = new SysUavTask();
            query.setTaskStatus("1");
            List<SysUavTask> runningTasks = sysUavTaskMapper.selectSysUavTaskList(query);

            for (SysUavTask task : runningTasks) {
                int currentProgress = task.getProgress() == null ? 0 : task.getProgress();
                if (currentProgress >= 100) continue;

                int increment = 1 + (int) (Math.random() * 3);
                int newProgress = Math.min(currentProgress + increment, 100);

                SysUavTask update = new SysUavTask();
                update.setTaskId(task.getTaskId());
                update.setProgress(newProgress);
                sysUavTaskMapper.updateSysUavTask(update);

                // 到达 100% 自动完成任务
                if (newProgress >= 100) {
                    try {
                        sysUavTaskService.completeTask(task.getTaskId());
                        log.info("任务[{}] \"{}\" 进度到达100%，已自动完成归档", task.getTaskId(), task.getTaskName());
                    } catch (Exception e) {
                        log.error("自动完成任务[{}]失败: {}", task.getTaskId(), e.getMessage());
                    }
                }
            }

            if (!runningTasks.isEmpty()) {
                log.debug("已更新 {} 个执行中任务的进度", runningTasks.size());
            }
        } catch (Exception e) {
            log.error("任务进度自动递增出错", e);
        }
    }
}
