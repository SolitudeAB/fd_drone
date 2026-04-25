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
import com.ruoair.uav.domain.SysUavResult;
import com.ruoair.uav.service.ISysUavResultService;
import com.ruoair.common.utils.poi.ExcelUtil;
import com.ruoair.common.core.page.TableDataInfo;

/**
 * 巡航结果Controller
 * 
 * @author jiax
 * @date 2026-04-25
 */
@RestController
@RequestMapping("/uav/result")
public class SysUavResultController extends BaseController
{
    @Autowired
    private ISysUavResultService sysUavResultService;

    /**
     * 查询巡航结果列表
     */
    @PreAuthorize("@ss.hasPermi('uav:result:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUavResult sysUavResult)
    {
        startPage();
        List<SysUavResult> list = sysUavResultService.selectSysUavResultList(sysUavResult);
        return getDataTable(list);
    }

    /**
     * 导出巡航结果列表
     */
    @PreAuthorize("@ss.hasPermi('uav:result:export')")
    @Log(title = "巡航结果", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysUavResult sysUavResult)
    {
        List<SysUavResult> list = sysUavResultService.selectSysUavResultList(sysUavResult);
        ExcelUtil<SysUavResult> util = new ExcelUtil<SysUavResult>(SysUavResult.class);
        util.exportExcel(response, list, "巡航结果数据");
    }

    /**
     * 获取巡航结果详细信息
     */
    @PreAuthorize("@ss.hasPermi('uav:result:query')")
    @GetMapping(value = "/{resultId}")
    public AjaxResult getInfo(@PathVariable("resultId") Long resultId)
    {
        return success(sysUavResultService.selectSysUavResultByResultId(resultId));
    }

    /**
     * 新增巡航结果
     */
    @PreAuthorize("@ss.hasPermi('uav:result:add')")
    @Log(title = "巡航结果", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysUavResult sysUavResult)
    {
        return toAjax(sysUavResultService.insertSysUavResult(sysUavResult));
    }

    /**
     * 修改巡航结果
     */
    @PreAuthorize("@ss.hasPermi('uav:result:edit')")
    @Log(title = "巡航结果", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysUavResult sysUavResult)
    {
        return toAjax(sysUavResultService.updateSysUavResult(sysUavResult));
    }

    /**
     * 删除巡航结果
     */
    @PreAuthorize("@ss.hasPermi('uav:result:remove')")
    @Log(title = "巡航结果", businessType = BusinessType.DELETE)
	@DeleteMapping("/{resultIds}")
    public AjaxResult remove(@PathVariable Long[] resultIds)
    {
        return toAjax(sysUavResultService.deleteSysUavResultByResultIds(resultIds));
    }
}
