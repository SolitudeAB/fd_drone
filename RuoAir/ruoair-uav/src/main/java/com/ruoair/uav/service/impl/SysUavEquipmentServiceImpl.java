package com.ruoair.uav.service.impl;

import java.util.List;

import com.ruoair.common.exception.ServiceException;
import com.ruoair.common.utils.DateUtils;
import com.ruoair.uav.domain.SysUavTask;
import com.ruoair.uav.mapper.SysUavTaskMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoair.uav.mapper.SysUavEquipmentMapper;
import com.ruoair.uav.domain.SysUavEquipment;
import com.ruoair.uav.service.ISysUavEquipmentService;

/**
 * 无人机设备Service业务层处理
 * 
 * @author ruoyi
 * @date 2026-04-25
 */
@Service
public class SysUavEquipmentServiceImpl implements ISysUavEquipmentService 
{
    @Autowired
    private SysUavEquipmentMapper sysUavEquipmentMapper;

    @Autowired
    private SysUavTaskMapper sysUavTaskMapper; // 注入任务表的Mapper

    /**
     * 查询无人机设备
     * 
     * @param equipmentId 无人机设备主键
     * @return 无人机设备
     */
    @Override
    public SysUavEquipment selectSysUavEquipmentByEquipmentId(Long equipmentId)
    {
        SysUavEquipment equipment = sysUavEquipmentMapper.selectSysUavEquipmentByEquipmentId(equipmentId);
        if (equipment != null)
        {
            SysUavTask query = new SysUavTask();
            query.setEquipmentId(equipmentId);
            List<SysUavTask> allTasks = sysUavTaskMapper.selectSysUavTaskList(query);
            equipment.setRelatedTasks(allTasks);
            long pendingCount = allTasks.stream().filter(t -> "0".equals(t.getTaskStatus())).count();
            long activeCount = allTasks.stream().filter(t -> "1".equals(t.getTaskStatus())).count();
            equipment.setPendingTaskCount((int) pendingCount);
            equipment.setActiveTaskCount((int) activeCount);
        }
        return equipment;
    }

    /**
     * 查询无人机设备列表
     * 
     * @param sysUavEquipment 无人机设备
     * @return 无人机设备
     */
    @Override
    public List<SysUavEquipment> selectSysUavEquipmentList(SysUavEquipment sysUavEquipment)
    {
        return sysUavEquipmentMapper.selectSysUavEquipmentList(sysUavEquipment);
    }

    /**
     * 新增无人机设备
     * 
     * @param sysUavEquipment 无人机设备
     * @return 结果
     */
    @Override
    public int insertSysUavEquipment(SysUavEquipment sysUavEquipment)
    {

        // 1. 校验设备编号是否唯一
        SysUavEquipment query = new SysUavEquipment();
        query.setEquipmentCode(sysUavEquipment.getEquipmentCode());
        // 假设你的 mapper 里有一个基础的查询列表方法
        List<SysUavEquipment> existingList = sysUavEquipmentMapper.selectSysUavEquipmentList(query);

        if (!existingList.isEmpty()) {
            // 抛出业务异常，前端会自动弹窗提示这句话
            throw new ServiceException("新增设备失败，设备编号 '" + sysUavEquipment.getEquipmentCode() + "' 已存在，请重新输入！");
        }
        sysUavEquipment.setCreateTime(DateUtils.getNowDate());
        return sysUavEquipmentMapper.insertSysUavEquipment(sysUavEquipment);
    }

    /**
     * 修改无人机设备
     * 
     * @param sysUavEquipment 无人机设备
     * @return 结果
     */
    @Override
    public int updateSysUavEquipment(SysUavEquipment sysUavEquipment)
    {
        SysUavEquipment query = new SysUavEquipment();
        query.setEquipmentCode(sysUavEquipment.getEquipmentCode());
        List<SysUavEquipment> existingList = sysUavEquipmentMapper.selectSysUavEquipmentList(query);
        for (SysUavEquipment existing : existingList)
        {
            if (!existing.getEquipmentId().equals(sysUavEquipment.getEquipmentId()))
            {
                throw new ServiceException("修改设备失败，设备编号 '" + sysUavEquipment.getEquipmentCode() + "' 已存在，请重新输入！");
            }
        }
        sysUavEquipment.setUpdateTime(DateUtils.getNowDate());
        return sysUavEquipmentMapper.updateSysUavEquipment(sysUavEquipment);
    }

    /**
     * 批量删除无人机设备
     * * @param equipmentIds 需要删除的无人机设备主键
     * @return 结果
     */
    @Override
    public int deleteSysUavEquipmentByEquipmentIds(Long[] equipmentIds)
    {
        for (Long equipmentId : equipmentIds)
        {
            // 1. 构造查询条件：检查该设备是否绑定了任务
            SysUavTask taskQuery = new SysUavTask();
            taskQuery.setEquipmentId(equipmentId);
            List<SysUavTask> taskList = sysUavTaskMapper.selectSysUavTaskList(taskQuery);

            // 2. 如果查询结果不为空，说明该设备正在被任务使用
            if (taskList != null && taskList.size() > 0)
            {
                // 先查出设备名称，让报错信息更具体
                SysUavEquipment equipment = sysUavEquipmentMapper.selectSysUavEquipmentByEquipmentId(equipmentId);
                throw new ServiceException("删除失败：设备【" + equipment.getEquipmentName() + "】已绑定巡防任务，请先删除关联的任务！");
            }
        }

        // 3. 所有设备都没有绑定任务，才执行真实的删除逻辑
        return sysUavEquipmentMapper.deleteSysUavEquipmentByEquipmentIds(equipmentIds);
    }

    /**
     * 删除无人机设备信息
     * * @param equipmentId 无人机设备主键
     * @return 结果
     */
    @Override
    public int deleteSysUavEquipmentByEquipmentId(Long equipmentId)
    {
        // 1. 检查该设备是否绑定了任务
        SysUavTask taskQuery = new SysUavTask();
        taskQuery.setEquipmentId(equipmentId);
        List<SysUavTask> taskList = sysUavTaskMapper.selectSysUavTaskList(taskQuery);

        if (taskList != null && taskList.size() > 0)
        {
            throw new ServiceException("该设备已绑定巡防任务，无法删除！");
        }

        return sysUavEquipmentMapper.deleteSysUavEquipmentByEquipmentId(equipmentId);
    }

    /**
     * 校验设备是否可用（用于任务开始前检查）
     */
    @Override
    public boolean checkEquipmentAvailable(Long equipmentId) {
        SysUavEquipment equipment = sysUavEquipmentMapper.selectSysUavEquipmentByEquipmentId(equipmentId);
        if (equipment == null) {
            throw new ServiceException("设备不存在！");
        }
        // status: 0=正常, 1=维修中, 2=已报废, 3=任务中
        if (!"0".equals(equipment.getStatus())) {
            String statusMsg = "";
            if ("1".equals(equipment.getStatus())) {
                statusMsg = "维修中";
            } else if ("2".equals(equipment.getStatus())) {
                statusMsg = "已报废";
            } else if ("3".equals(equipment.getStatus())) {
                statusMsg = "任务中";
            } else {
                statusMsg = "未知状态";
            }
            throw new ServiceException("设备【" + equipment.getEquipmentName() + "】当前状态为【" + statusMsg + "】，无法执行任务！");
        }
        return true;
    }

    /**
     * 更新设备状态
     */
    @Override
    public int updateEquipmentStatus(Long equipmentId, String status) {
        SysUavEquipment equipment = new SysUavEquipment();
        equipment.setEquipmentId(equipmentId);
        equipment.setStatus(status);
        equipment.setUpdateTime(DateUtils.getNowDate());
        return sysUavEquipmentMapper.updateSysUavEquipment(equipment);
    }
}
