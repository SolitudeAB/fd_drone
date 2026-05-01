package com.ruoair.uav.mapper;

import java.util.List;
import com.ruoair.uav.domain.SysUavEquipment;

/**
 * 无人机设备Mapper接口
 * 
 * @author ruoyi
 * @date 2026-04-25
 */
public interface SysUavEquipmentMapper 
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
     * 删除无人机设备
     * 
     * @param equipmentId 无人机设备主键
     * @return 结果
     */
    public int deleteSysUavEquipmentByEquipmentId(Long equipmentId);

    /**
     * 批量删除无人机设备
     * 
     * @param equipmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteSysUavEquipmentByEquipmentIds(Long[] equipmentIds);
}
