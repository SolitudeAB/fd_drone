package com.ruoair.uav.service.impl;

import java.util.List;
import com.ruoair.common.exception.ServiceException;
import com.ruoair.common.utils.DateUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoair.uav.mapper.SysUavResultMapper;
import com.ruoair.uav.domain.SysUavResult;
import com.ruoair.uav.service.ISysUavResultService;

/**
 * 巡航结果Service业务层处理
 * 
 * @author jiax
 * @date 2026-04-25
 */
@Service
public class SysUavResultServiceImpl implements ISysUavResultService 
{
    @Autowired
    private SysUavResultMapper sysUavResultMapper;

    /**
     * 查询巡航结果
     * 
     * @param resultId 巡航结果主键
     * @return 巡航结果
     */
    @Override
    public SysUavResult selectSysUavResultByResultId(Long resultId)
    {
        return sysUavResultMapper.selectSysUavResultByResultId(resultId);
    }

    /**
     * 查询巡航结果列表
     * 
     * @param sysUavResult 巡航结果
     * @return 巡航结果
     */
    @Override
    public List<SysUavResult> selectSysUavResultList(SysUavResult sysUavResult)
    {
        return sysUavResultMapper.selectSysUavResultList(sysUavResult);
    }

    /**
     * 新增巡航结果
     * 
     * @param sysUavResult 巡航结果
     * @return 结果
     */
    @Override
    public int insertSysUavResult(SysUavResult sysUavResult)
    {
        validateResult(sysUavResult);
        sysUavResult.setCreateTime(DateUtils.getNowDate());
        return sysUavResultMapper.insertSysUavResult(sysUavResult);
    }

    /**
     * 修改巡航结果
     * 
     * @param sysUavResult 巡航结果
     * @return 结果
     */
    @Override
    public int updateSysUavResult(SysUavResult sysUavResult)
    {
        validateResult(sysUavResult);
        sysUavResult.setUpdateTime(DateUtils.getNowDate());
        return sysUavResultMapper.updateSysUavResult(sysUavResult);
    }

    /**
     * 批量删除巡航结果
     * 
     * @param resultIds 需要删除的巡航结果主键
     * @return 结果
     */
    @Override
    public int deleteSysUavResultByResultIds(Long[] resultIds)
    {
        return sysUavResultMapper.deleteSysUavResultByResultIds(resultIds);
    }

    /**
     * 删除巡航结果信息
     * 
     * @param resultId 巡航结果主键
     * @return 结果
     */
    @Override
    public int deleteSysUavResultByResultId(Long resultId)
    {
        return sysUavResultMapper.deleteSysUavResultByResultId(resultId);
    }

    private void validateResult(SysUavResult sysUavResult)
    {
        if (sysUavResult == null || StringUtils.isBlank(sysUavResult.getOverview()))
        {
            throw new ServiceException("巡航概述不能为空！");
        }
    }
}
