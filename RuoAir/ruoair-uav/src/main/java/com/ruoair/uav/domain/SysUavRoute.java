package com.ruoair.uav.domain;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoair.common.annotation.Excel;
import com.ruoair.common.core.domain.BaseEntity;

/**
 * 巡航航线对象 sys_uav_route
 * 
 * @author jaix
 * @date 2026-04-25
 */
public class SysUavRoute extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 航线ID */
    private Long routeId;

    /** 航线名称 */
    @Excel(name = "航线名称")
    private String routeName;

    /** 预计时长 */
    @Excel(name = "预计时长")
    private Long estimatedTime;

    /** 飞行高度 */
    @Excel(name = "飞行高度")
    private BigDecimal flightAltitude;

    /** 航线点位 */
    private String routePoints;

    public void setRouteId(Long routeId) 
    {
        this.routeId = routeId;
    }

    public Long getRouteId() 
    {
        return routeId;
    }

    public void setRouteName(String routeName) 
    {
        this.routeName = routeName;
    }

    public String getRouteName() 
    {
        return routeName;
    }

    public void setEstimatedTime(Long estimatedTime) 
    {
        this.estimatedTime = estimatedTime;
    }

    public Long getEstimatedTime() 
    {
        return estimatedTime;
    }

    public void setFlightAltitude(BigDecimal flightAltitude) 
    {
        this.flightAltitude = flightAltitude;
    }

    public BigDecimal getFlightAltitude() 
    {
        return flightAltitude;
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
            .append("routeId", getRouteId())
            .append("routeName", getRouteName())
            .append("estimatedTime", getEstimatedTime())
            .append("flightAltitude", getFlightAltitude())
            .append("routePoints", getRoutePoints())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}
