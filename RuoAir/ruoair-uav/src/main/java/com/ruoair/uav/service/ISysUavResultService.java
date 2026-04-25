package com.ruoair.uav.service;

import java.util.List;
import com.ruoair.uav.domain.SysUavResult;

/**
 * 巡航结果Service接口
 * 
 * @author jiax
 * @date 2026-04-25
 */
public interface ISysUavResultService 
{
    /**
     * 查询巡航结果
     * 
     * @param resultId 巡航结果主键
     * @return 巡航结果
     */
    public SysUavResult selectSysUavResultByResultId(Long resultId);

    /**
     * 查询巡航结果列表
     * 
     * @param sysUavResult 巡航结果
     * @return 巡航结果集合
     */
    public List<SysUavResult> selectSysUavResultList(SysUavResult sysUavResult);

    /**
     * 新增巡航结果
     * 
     * @param sysUavResult 巡航结果
     * @return 结果
     */
    public int insertSysUavResult(SysUavResult sysUavResult);

    /**
     * 修改巡航结果
     * 
     * @param sysUavResult 巡航结果
     * @return 结果
     */
    public int updateSysUavResult(SysUavResult sysUavResult);

    /**
     * 批量删除巡航结果
     * 
     * @param resultIds 需要删除的巡航结果主键集合
     * @return 结果
     */
    public int deleteSysUavResultByResultIds(Long[] resultIds);

    /**
     * 删除巡航结果信息
     * 
     * @param resultId 巡航结果主键
     * @return 结果
     */
    public int deleteSysUavResultByResultId(Long resultId);
}
