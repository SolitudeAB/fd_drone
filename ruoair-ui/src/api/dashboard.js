import request from '@/utils/request'

// 获取首页大盘统计数据
export function getStats() {
  return request({
    url: '/uav/dashboard/stats',
    method: 'get'
  })
}
