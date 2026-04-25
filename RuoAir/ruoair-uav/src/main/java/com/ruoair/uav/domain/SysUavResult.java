package com.ruoair.uav.domain;

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
    private String findings;

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

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("resultId", getResultId())
            .append("resultCode", getResultCode())
            .append("taskId", getTaskId())
            .append("overview", getOverview())
            .append("findings", getFindings())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
