package com.ruoair.uav.service.impl;

import java.util.List;
import com.ruoair.common.exception.ServiceException;
import com.ruoair.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoair.uav.mapper.SysUavRouteMapper;
import com.ruoair.uav.mapper.SysUavTaskMapper;
import com.ruoair.uav.domain.SysUavRoute;
import com.ruoair.uav.domain.SysUavTask;
import com.ruoair.uav.service.ISysUavRouteService;

/**
 * 巡航航线Service业务层处理
 * 
 * @author jaix
 * @date 2026-04-25
 */
@Service
public class SysUavRouteServiceImpl implements ISysUavRouteService 
{
    @Autowired
    private SysUavRouteMapper sysUavRouteMapper;

    @Autowired
    private SysUavTaskMapper sysUavTaskMapper;

    /**
     * 查询巡航航线
     * 
     * @param routeId 巡航航线主键
     * @return 巡航航线
     */
    @Override
    public SysUavRoute selectSysUavRouteByRouteId(Long routeId)
    {
        SysUavRoute route = sysUavRouteMapper.selectSysUavRouteByRouteId(routeId);
        if (route != null)
        {
            SysUavTask query = new SysUavTask();
            query.setRouteId(routeId);
            route.setRelatedTasks(sysUavTaskMapper.selectSysUavTaskList(query));
        }
        return route;
    }

    /**
     * 查询巡航航线列表
     * 
     * @param sysUavRoute 巡航航线
     * @return 巡航航线
     */
    @Override
    public List<SysUavRoute> selectSysUavRouteList(SysUavRoute sysUavRoute)
    {
        return sysUavRouteMapper.selectSysUavRouteList(sysUavRoute);
    }

    /**
     * 新增巡航航线
     * 
     * @param sysUavRoute 巡航航线
     * @return 结果
     */
    @Override
    public int insertSysUavRoute(SysUavRoute sysUavRoute)
    {
        sysUavRoute.setCreateTime(DateUtils.getNowDate());
        return sysUavRouteMapper.insertSysUavRoute(sysUavRoute);
    }

    /**
     * 修改巡航航线
     * 
     * @param sysUavRoute 巡航航线
     * @return 结果
     */
    @Override
    public int updateSysUavRoute(SysUavRoute sysUavRoute)
    {
        sysUavRoute.setUpdateTime(DateUtils.getNowDate());
        return sysUavRouteMapper.updateSysUavRoute(sysUavRoute);
    }

    /**
     * 批量删除巡航航线
     * 
     * @param routeIds 需要删除的巡航航线主键
     * @return 结果
     */
    @Override
    public int deleteSysUavRouteByRouteIds(Long[] routeIds)
    {
        for (Long routeId : routeIds)
        {
            assertRouteCanDelete(routeId);
        }
        return sysUavRouteMapper.deleteSysUavRouteByRouteIds(routeIds);
    }

    /**
     * 删除巡航航线信息
     * 
     * @param routeId 巡航航线主键
     * @return 结果
     */
    @Override
    public int deleteSysUavRouteByRouteId(Long routeId)
    {
        assertRouteCanDelete(routeId);
        return sysUavRouteMapper.deleteSysUavRouteByRouteId(routeId);
    }

    private void assertRouteCanDelete(Long routeId)
    {
        SysUavTask query = new SysUavTask();
        query.setRouteId(routeId);
        List<SysUavTask> tasks = sysUavTaskMapper.selectSysUavTaskList(query);
        for (SysUavTask task : tasks)
        {
            if (!"2".equals(task.getTaskStatus()) && !"3".equals(task.getTaskStatus()))
            {
                throw new ServiceException("航线【" + task.getRouteName() + "】存在未完成任务，禁止删除！");
            }
        }
    }
}
