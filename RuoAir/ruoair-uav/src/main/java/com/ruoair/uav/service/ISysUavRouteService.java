package com.ruoair.uav.service;

import java.util.List;
import com.ruoair.uav.domain.SysUavRoute;

/**
 * 巡航航线Service接口
 * 
 * @author jaix
 * @date 2026-04-25
 */
public interface ISysUavRouteService 
{
    /**
     * 查询巡航航线
     * 
     * @param routeId 巡航航线主键
     * @return 巡航航线
     */
    public SysUavRoute selectSysUavRouteByRouteId(Long routeId);

    /**
     * 查询巡航航线列表
     * 
     * @param sysUavRoute 巡航航线
     * @return 巡航航线集合
     */
    public List<SysUavRoute> selectSysUavRouteList(SysUavRoute sysUavRoute);

    /**
     * 新增巡航航线
     * 
     * @param sysUavRoute 巡航航线
     * @return 结果
     */
    public int insertSysUavRoute(SysUavRoute sysUavRoute);

    /**
     * 修改巡航航线
     * 
     * @param sysUavRoute 巡航航线
     * @return 结果
     */
    public int updateSysUavRoute(SysUavRoute sysUavRoute);

    /**
     * 批量删除巡航航线
     * 
     * @param routeIds 需要删除的巡航航线主键集合
     * @return 结果
     */
    public int deleteSysUavRouteByRouteIds(Long[] routeIds);

    /**
     * 删除巡航航线信息
     * 
     * @param routeId 巡航航线主键
     * @return 结果
     */
    public int deleteSysUavRouteByRouteId(Long routeId);
}
