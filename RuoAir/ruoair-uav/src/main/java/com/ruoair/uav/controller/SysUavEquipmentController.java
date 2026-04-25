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
import com.ruoair.uav.domain.SysUavEquipment;
import com.ruoair.uav.service.ISysUavEquipmentService;
import com.ruoair.common.utils.poi.ExcelUtil;
import com.ruoair.common.core.page.TableDataInfo;

/**
 * 无人机设备Controller
 * 
 * @author ruoyi
 * @date 2026-04-25
 */
@RestController
@RequestMapping("/uav/equipment")
public class SysUavEquipmentController extends BaseController
{
    @Autowired
    private ISysUavEquipmentService sysUavEquipmentService;

    /**
     * 查询无人机设备列表
     */
    @PreAuthorize("@ss.hasPermi('uav:equipment:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUavEquipment sysUavEquipment)
    {
        startPage();
        List<SysUavEquipment> list = sysUavEquipmentService.selectSysUavEquipmentList(sysUavEquipment);
        return getDataTable(list);
    }

    /**
     * 导出无人机设备列表
     */
    @PreAuthorize("@ss.hasPermi('uav:equipment:export')")
    @Log(title = "无人机设备", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysUavEquipment sysUavEquipment)
    {
        List<SysUavEquipment> list = sysUavEquipmentService.selectSysUavEquipmentList(sysUavEquipment);
        ExcelUtil<SysUavEquipment> util = new ExcelUtil<SysUavEquipment>(SysUavEquipment.class);
        util.exportExcel(response, list, "无人机设备数据");
    }

    /**
     * 获取无人机设备详细信息
     */
    @PreAuthorize("@ss.hasPermi('uav:equipment:query')")
    @GetMapping(value = "/{equipmentId}")
    public AjaxResult getInfo(@PathVariable("equipmentId") Long equipmentId)
    {
        return success(sysUavEquipmentService.selectSysUavEquipmentByEquipmentId(equipmentId));
    }

    /**
     * 新增无人机设备
     */
    @PreAuthorize("@ss.hasPermi('uav:equipment:add')")
    @Log(title = "无人机设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysUavEquipment sysUavEquipment)
    {
        return toAjax(sysUavEquipmentService.insertSysUavEquipment(sysUavEquipment));
    }

    /**
     * 修改无人机设备
     */
    @PreAuthorize("@ss.hasPermi('uav:equipment:edit')")
    @Log(title = "无人机设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysUavEquipment sysUavEquipment)
    {
        return toAjax(sysUavEquipmentService.updateSysUavEquipment(sysUavEquipment));
    }

    /**
     * 删除无人机设备
     */
    @PreAuthorize("@ss.hasPermi('uav:equipment:remove')")
    @Log(title = "无人机设备", businessType = BusinessType.DELETE)
	@DeleteMapping("/{equipmentIds}")
    public AjaxResult remove(@PathVariable Long[] equipmentIds)
    {
        return toAjax(sysUavEquipmentService.deleteSysUavEquipmentByEquipmentIds(equipmentIds));
    }
}
