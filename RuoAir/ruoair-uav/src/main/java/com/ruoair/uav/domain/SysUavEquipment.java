package com.ruoair.uav.domain;

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

    /** 设备状态 */
    @Excel(name = "设备状态")
    private String status;

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

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("equipmentId", getEquipmentId())
            .append("equipmentCode", getEquipmentCode())
            .append("equipmentName", getEquipmentName())
            .append("equipmentModel", getEquipmentModel())
            .append("flightDuration", getFlightDuration())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
