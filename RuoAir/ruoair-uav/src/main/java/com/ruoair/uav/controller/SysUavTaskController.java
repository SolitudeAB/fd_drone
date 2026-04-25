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
import com.ruoair.uav.domain.SysUavTask;
import com.ruoair.uav.service.ISysUavTaskService;
import com.ruoair.common.utils.poi.ExcelUtil;
import com.ruoair.common.core.page.TableDataInfo;

/**
 * 巡航任务Controller
 * 
 * @author jiax
 * @date 2026-04-25
 */
@RestController
@RequestMapping("/uav/task")
public class SysUavTaskController extends BaseController
{
    @Autowired
    private ISysUavTaskService sysUavTaskService;

    /**
     * 查询巡航任务列表
     */
    @PreAuthorize("@ss.hasPermi('uav:task:list')")
    @GetMapping("/list")
    public TableDataInfo list(SysUavTask sysUavTask)
    {
        startPage();
        List<SysUavTask> list = sysUavTaskService.selectSysUavTaskList(sysUavTask);
        return getDataTable(list);
    }

    /**
     * 导出巡航任务列表
     */
    @PreAuthorize("@ss.hasPermi('uav:task:export')")
    @Log(title = "巡航任务", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysUavTask sysUavTask)
    {
        List<SysUavTask> list = sysUavTaskService.selectSysUavTaskList(sysUavTask);
        ExcelUtil<SysUavTask> util = new ExcelUtil<SysUavTask>(SysUavTask.class);
        util.exportExcel(response, list, "巡航任务数据");
    }

    /**
     * 获取巡航任务详细信息
     */
    @PreAuthorize("@ss.hasPermi('uav:task:query')")
    @GetMapping(value = "/{taskId}")
    public AjaxResult getInfo(@PathVariable("taskId") Long taskId)
    {
        return success(sysUavTaskService.selectSysUavTaskByTaskId(taskId));
    }

    /**
     * 新增巡航任务
     */
    @PreAuthorize("@ss.hasPermi('uav:task:add')")
    @Log(title = "巡航任务", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysUavTask sysUavTask)
    {
        return toAjax(sysUavTaskService.insertSysUavTask(sysUavTask));
    }

    /**
     * 修改巡航任务
     */
    @PreAuthorize("@ss.hasPermi('uav:task:edit')")
    @Log(title = "巡航任务", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysUavTask sysUavTask)
    {
        return toAjax(sysUavTaskService.updateSysUavTask(sysUavTask));
    }

    /**
     * 删除巡航任务
     */
    @PreAuthorize("@ss.hasPermi('uav:task:remove')")
    @Log(title = "巡航任务", businessType = BusinessType.DELETE)
	@DeleteMapping("/{taskIds}")
    public AjaxResult remove(@PathVariable Long[] taskIds)
    {
        return toAjax(sysUavTaskService.deleteSysUavTaskByTaskIds(taskIds));
    }
}
