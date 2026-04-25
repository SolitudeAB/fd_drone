package com.ruoair.uav.service;

import java.util.List;
import com.ruoair.uav.domain.SysUavEquipment;

/**
 * 无人机设备Service接口
 * 
 * @author ruoyi
 * @date 2026-04-25
 */
public interface ISysUavEquipmentService 
{
    /**
     * 查询无人机设备
     * 
     * @param equipmentId 无人机设备主键
     * @return 无人机设备
     */
    public SysUavEquipment selectSysUavEquipmentByEquipmentId(Long equipmentId);

    /**
     * 查询无人机设备列表
     * 
     * @param sysUavEquipment 无人机设备
     * @return 无人机设备集合
     */
    public List<SysUavEquipment> selectSysUavEquipmentList(SysUavEquipment sysUavEquipment);

    /**
     * 新增无人机设备
     * 
     * @param sysUavEquipment 无人机设备
     * @return 结果
     */
    public int insertSysUavEquipment(SysUavEquipment sysUavEquipment);

    /**
     * 修改无人机设备
     * 
     * @param sysUavEquipment 无人机设备
     * @return 结果
     */
    public int updateSysUavEquipment(SysUavEquipment sysUavEquipment);

    /**
     * 批量删除无人机设备
     * 
     * @param equipmentIds 需要删除的无人机设备主键集合
     * @return 结果
     */
    public int deleteSysUavEquipmentByEquipmentIds(Long[] equipmentIds);

    /**
     * 删除无人机设备信息
     * 
     * @param equipmentId 无人机设备主键
     * @return 结果
     */
    public int deleteSysUavEquipmentByEquipmentId(Long equipmentId);

    /**
     * 校验设备是否可用（用于任务开始前检查）
     *
     * @param equipmentId 设备ID
     * @return true=可用, false=不可用
     */
    public boolean checkEquipmentAvailable(Long equipmentId);

    /**
     * 更新设备状态
     *
     * @param equipmentId 设备ID
     * @param status 状态：0空闲,1离线,2故障,3任务中
     * @return 结果
     */
    public int updateEquipmentStatus(Long equipmentId, String status);
}
