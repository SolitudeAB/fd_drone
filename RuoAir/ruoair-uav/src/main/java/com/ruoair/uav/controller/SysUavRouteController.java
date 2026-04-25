package com.ruoair.uav.controller;

import java.util.List;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoair.common.annotation.Log;
import com.ruoair.common.core.controller.BaseController;
import com.ruoair.common.core.domain.AjaxResult;
import com.ruoair.common.enums.BusinessType;
import com.ruoair.uav.domain.SysUavRoute;
import com.ruoair.uav.service.ISysUavRouteService;
import com.ruoair.common.utils.poi.ExcelUtil;
import com.ruoair.common.core.page.TableDataInfo;

/**
 * 巡航航线Controller
 * 
 * @author jaix
 * @date 2026-04-25
 */
@RestController
@RequestMapping("/uav/route")
public class SysUavRouteController extends BaseController
{
    @Autowired
    private ISysUavRouteService sysUavRouteService;

    /**
     * 查询巡航航线列表
     */
    @PreAuthorize("@ss.hasPermi('uav:route:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUavRoute sysUavRoute)
    {
        startPage();
        List<SysUavRoute> list = sysUavRouteService.selectSysUavRouteList(sysUavRoute);
        return getDataTable(list);
    }

    /**
     * 导出巡航航线列表
     */
    @PreAuthorize("@ss.hasPermi('uav:route:export')")
    @Log(title = "巡航航线", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysUavRoute sysUavRoute)
    {
        List<SysUavRoute> list = sysUavRouteService.selectSysUavRouteList(sysUavRoute);
        ExcelUtil<SysUavRoute> util = new ExcelUtil<SysUavRoute>(SysUavRoute.class);
        util.exportExcel(response, list, "巡航航线数据");
    }

    /**
     * 获取巡航航线详细信息
     */
    @PreAuthorize("@ss.hasPermi('uav:route:query')")
    @GetMapping(value = "/{routeId}")
    public AjaxResult getInfo(@PathVariable("routeId") Long routeId)
    {
        return success(sysUavRouteService.selectSysUavRouteByRouteId(routeId));
    }

    /**
     * 新增巡航航线
     */
    @PreAuthorize("@ss.hasPermi('uav:route:add')")
    @Log(title = "巡航航线", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysUavRoute sysUavRoute)
    {
        return toAjax(sysUavRouteService.insertSysUavRoute(sysUavRoute));
    }

    /**
     * 修改巡航航线
     */
    @PreAuthorize("@ss.hasPermi('uav:route:edit')")
    @Log(title = "巡航航线", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysUavRoute sysUavRoute)
    {
        return toAjax(sysUavRouteService.updateSysUavRoute(sysUavRoute));
    }

    /**
     * 删除巡航航线
     */
    @PreAuthorize("@ss.hasPermi('uav:route:remove')")
    @Log(title = "巡航航线", businessType = BusinessType.DELETE)
	@DeleteMapping("/{routeIds}")
    public AjaxResult remove(@PathVariable Long[] routeIds)
    {
        return toAjax(sysUavRouteService.deleteSysUavRouteByRouteIds(routeIds));
    }
}
