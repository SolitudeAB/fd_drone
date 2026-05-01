package com.ruoair.uav.domain;

import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoair.common.annotation.Excel;
import com.ruoair.common.core.domain.BaseEntity;

/**
 * 无人机设备对象 sys_uav_equipment
 * 
 * @author ruoyi
 * @date 2026-04-25
 */
public class SysUavEquipment extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备ID */
    private Long equipmentId;

    /** 设备编号 */
    @Excel(name = "设备编号")
    private String equipmentCode;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String equipmentName;

    /** 设备型号 */
    @Excel(name = "设备型号")
    private String equipmentModel;

    /** 续航时长 */
    @Excel(name = "续航时长")
    private Long flightDuration;

    /** 摄像头参数 */
    @Excel(name = "摄像头参数")
    private String cameraParams;

    /** 归属人 */
    @Excel(name = "归属人")
    private String owner;

    /** 设备状态 */
    @Excel(name = "设备状态")
    private String status;

    /** 关联历史任务 */
    private List<SysUavTask> relatedTasks;

    /** 待执行任务数 */
    private int pendingTaskCount;

    /** 执行中任务数 */
    private int activeTaskCount;

    public void setEquipmentId(Long equipmentId) 
    {
        this.equipmentId = equipmentId;
    }

    public Long getEquipmentId() 
    {
        return equipmentId;
    }

    public void setEquipmentCode(String equipmentCode) 
    {
        this.equipmentCode = equipmentCode;
    }

    public String getEquipmentCode() 
    {
        return equipmentCode;
    }

    public void setEquipmentName(String equipmentName) 
    {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentName() 
    {
        return equipmentName;
    }

    public void setEquipmentModel(String equipmentModel) 
    {
        this.equipmentModel = equipmentModel;
    }

    public String getEquipmentModel() 
    {
        return equipmentModel;
    }

    public void setFlightDuration(Long flightDuration) 
    {
        this.flightDuration = flightDuration;
    }

    public Long getFlightDuration() 
    {
        return flightDuration;
    }

    public void setCameraParams(String cameraParams)
    {
        this.cameraParams = cameraParams;
    }

    public String getCameraParams()
    {
        return cameraParams;
    }

    public void setOwner(String owner)
    {
        this.owner = owner;
    }

    public String getOwner()
    {
        return owner;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setRelatedTasks(List<SysUavTask> relatedTasks)
    {
        this.relatedTasks = relatedTasks;
    }

    public List<SysUavTask> getRelatedTasks()
    {
        return relatedTasks;
    }

    public void setPendingTaskCount(int pendingTaskCount)
    {
        this.pendingTaskCount = pendingTaskCount;
    }

    public int getPendingTaskCount()
    {
        return pendingTaskCount;
    }

    public void setActiveTaskCount(int activeTaskCount)
    {
        this.activeTaskCount = activeTaskCount;
    }

    public int getActiveTaskCount()
    {
        return activeTaskCount;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("equipmentId", getEquipmentId())
            .append("equipmentCode", getEquipmentCode())
            .append("equipmentName", getEquipmentName())
            .append("equipmentModel", getEquipmentModel())
            .append("flightDuration", getFlightDuration())
            .append("cameraParams", getCameraParams())
            .append("owner", getOwner())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
