import request from '@/utils/request'

export function getDashboardStats() {
  return request({
    url: '/uav/dashboard/stats',
    method: 'get'
  })
}
