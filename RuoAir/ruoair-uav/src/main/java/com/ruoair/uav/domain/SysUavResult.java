package com.ruoair.uav.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoair.common.annotation.Excel;
import com.ruoair.common.core.domain.BaseEntity;

/**
 * 巡航结果对象 sys_uav_result
 * 
 * @author jiax
 * @date 2026-04-25
 */
public class SysUavResult extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 结果ID */
    private Long resultId;

    /** 结果编号 */
    @Excel(name = "结果编号")
    private String resultCode;

    /** 任务ID */
    @Excel(name = "任务ID")
    private Long taskId;

    /** 巡航概述 */
    @Excel(name = "巡航概述")
    private String overview;

    /** 发现情况 */
    @Excel(name = "发现情况")
    private String findings;

    /** 任务名称（快照） */
    @Excel(name = "任务名称")
    private String taskName;

    /** 设备名称（快照） */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 航线名称（快照） */
    @Excel(name = "航线名称")
    private String routeName;

    /** 执行人（快照） */
    @Excel(name = "执行人")
    private String executor;

    /** 巡防时长(分钟) */
    @Excel(name = "巡防时长(分钟)")
    private Long patrolDuration;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "完成时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date completedTime;

    /** 处理情况 */
    @Excel(name = "处理情况")
    private String handlingInfo;

    /** AI图片路径 */
    @Excel(name = "AI图片路径")
    private String aiImageUrl;

    /** 航线点位快照 */
    private String routePoints;

    public void setResultId(Long resultId) 
    {
        this.resultId = resultId;
    }

    public Long getResultId() 
    {
        return resultId;
    }

    public void setResultCode(String resultCode) 
    {
        this.resultCode = resultCode;
    }

    public String getResultCode() 
    {
        return resultCode;
    }

    public void setTaskId(Long taskId) 
    {
        this.taskId = taskId;
    }

    public Long getTaskId() 
    {
        return taskId;
    }

    public void setOverview(String overview) 
    {
        this.overview = overview;
    }

    public String getOverview() 
    {
        return overview;
    }

    public void setFindings(String findings) 
    {
        this.findings = findings;
    }

    public String getFindings() 
    {
        return findings;
    }

    public void setTaskName(String taskName)
    {
        this.taskName = taskName;
    }

    public String getTaskName()
    {
        return taskName;
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

    public void setExecutor(String executor)
    {
        this.executor = executor;
    }

    public String getExecutor()
    {
        return executor;
    }

    public void setPatrolDuration(Long patrolDuration)
    {
        this.patrolDuration = patrolDuration;
    }

    public Long getPatrolDuration()
    {
        return patrolDuration;
    }

    public void setCompletedTime(Date completedTime)
    {
        this.completedTime = completedTime;
    }

    public Date getCompletedTime()
    {
        return completedTime;
    }

    public void setHandlingInfo(String handlingInfo)
    {
        this.handlingInfo = handlingInfo;
    }

    public String getHandlingInfo()
    {
        return handlingInfo;
    }

    public void setAiImageUrl(String aiImageUrl)
    {
        this.aiImageUrl = aiImageUrl;
    }

    public String getAiImageUrl()
    {
        return aiImageUrl;
    }

    public void setRoutePoints(String routePoints)
    {
        this.routePoints = routePoints;
    }

    public String getRoutePoints()
    {
        return routePoints;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("resultId", getResultId())
            .append("resultCode", getResultCode())
            .append("taskId", getTaskId())
            .append("taskName", getTaskName())
            .append("equipmentName", getEquipmentName())
            .append("routeName", getRouteName())
            .append("executor", getExecutor())
            .append("patrolDuration", getPatrolDuration())
            .append("completedTime", getCompletedTime())
            .append("overview", getOverview())
            .append("findings", getFindings())
            .append("handlingInfo", getHandlingInfo())
            .append("routePoints", getRoutePoints())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
