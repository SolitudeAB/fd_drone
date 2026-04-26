package com.ruoair.uav.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoair.common.annotation.Excel;
import com.ruoair.common.core.domain.BaseEntity;

/**
 * 巡航任务对象 sys_uav_task
 * 
 * @author jiax
 * @date 2026-04-25
 */
public class SysUavTask extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 任务ID */
    private Long taskId;

    /** 任务名称 */
    @Excel(name = "任务名称")
    private String taskName;

    /** 任务描述 */
    @Excel(name = "任务描述")
    private String taskDescription;

    /** 设备ID */
    @Excel(name = "设备ID")
    private Long equipmentId;

    /** 航线ID */
    @Excel(name = "航线ID")
    private Long routeId;

    /** 任务状态 */
    @Excel(name = "任务状态")
    private String taskStatus;

    /** 开始时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "开始时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 结束时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "结束时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;

    /** 执行人 */
    @Excel(name = "执行人")
    private String executor;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 航线名称 */
    @Excel(name = "航线名称")
    private String routeName;

    /** 进度 (0-100) */
    @Excel(name = "进度")
    private Integer progress;

    /** 状态变更记录 */
    private String statusHistory;

    public void setTaskId(Long taskId) 
    {
        this.taskId = taskId;
    }

    public Long getTaskId() 
    {
        return taskId;
    }

    public void setTaskName(String taskName) 
    {
        this.taskName = taskName;
    }

    public String getTaskName() 
    {
        return taskName;
    }

    public void setTaskDescription(String taskDescription)
    {
        this.taskDescription = taskDescription;
    }

    public String getTaskDescription()
    {
        return taskDescription;
    }

    public void setEquipmentId(Long equipmentId) 
    {
        this.equipmentId = equipmentId;
    }

    public Long getEquipmentId() 
    {
        return equipmentId;
    }

    public void setRouteId(Long routeId) 
    {
        this.routeId = routeId;
    }

    public Long getRouteId() 
    {
        return routeId;
    }

    public void setTaskStatus(String taskStatus) 
    {
        this.taskStatus = taskStatus;
    }

    public String getTaskStatus() 
    {
        return taskStatus;
    }

    public void setStartTime(Date startTime) 
    {
        this.startTime = startTime;
    }

    public Date getStartTime() 
    {
        return startTime;
    }

    public void setEndTime(Date endTime) 
    {
        this.endTime = endTime;
    }

    public Date getEndTime() 
    {
        return endTime;
    }

    public void setExecutor(String executor)
    {
        this.executor = executor;
    }

    public String getExecutor()
    {
        return executor;
    }

    public void setEquipmentName(String equipmentName)
    {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentName()
    {
        return equipmentName;
    }

    public void setRouteName(String routeName)
    {
        this.routeName = routeName;
    }

    public String getRouteName()
    {
        return routeName;
    }

    public void setProgress(Integer progress)
    {
        this.progress = progress;
    }

    public Integer getProgress()
    {
        return progress;
    }

    public void setStatusHistory(String statusHistory)
    {
        this.statusHistory = statusHistory;
    }

    public String getStatusHistory()
    {
        return statusHistory;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("taskId", getTaskId())
            .append("taskName", getTaskName())
            .append("taskDescription", getTaskDescription())
            .append("equipmentId", getEquipmentId())
            .append("routeId", getRouteId())
            .append("taskStatus", getTaskStatus())
            .append("startTime", getStartTime())
            .append("endTime", getEndTime())
            .append("executor", getExecutor())
            .append("equipmentName", getEquipmentName())
            .append("routeName", getRouteName())
            .append("progress", getProgress())
            .append("statusHistory", getStatusHistory())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
