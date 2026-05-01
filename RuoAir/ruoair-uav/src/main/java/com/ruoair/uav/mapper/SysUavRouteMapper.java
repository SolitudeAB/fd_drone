package com.ruoair.uav.mapper;

import java.util.List;
import com.ruoair.uav.domain.SysUavRoute;

/**
 * 巡航航线Mapper接口
 * 
 * @author jaix
 * @date 2026-04-25
 */
public interface SysUavRouteMapper 
{
    /**
     * 查询巡航航线
     * 
     * @param routeId 巡航航线主键
     * @return 巡航航线
     */
    public SysUavRoute selectSysUavRouteByRouteId(Long routeId);

    /**
     * 根据航线名称精确查询
     * 
     * @param routeName 航线名称
     * @return 巡航航线
     */
    public SysUavRoute selectSysUavRouteByRouteName(String routeName);

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
     * 删除巡航航线
     * 
     * @param routeId 巡航航线主键
     * @return 结果
     */
    public int deleteSysUavRouteByRouteId(Long routeId);

    /**
     * 批量删除巡航航线
     * 
     * @param routeIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysUavRouteByRouteIds(Long[] routeIds);
}
