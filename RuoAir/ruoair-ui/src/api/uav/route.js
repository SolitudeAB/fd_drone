import request from '@/utils/request'

// 查询巡航航线列表
export function listRoute(query) {
  return request({
    url: '/uav/route/list',
    method: 'get',
    params: query
  })
}

// 查询巡航航线详细
export function getRoute(routeId) {
  return request({
    url: '/uav/route/' + routeId,
    method: 'get'
  })
}

// 新增巡航航线
export function addRoute(data) {
  return request({
    url: '/uav/route',
    method: 'post',
    data: data
  })
}

// 修改巡航航线
export function updateRoute(data) {
  return request({
    url: '/uav/route',
    method: 'put',
    data: data
  })
}

// 删除巡航航线
export function delRoute(routeId) {
  return request({
    url: '/uav/route/' + routeId,
    method: 'delete'
  })
}

// 更新航线点位
export function updateRoutePoints(routeId, routePoints) {
  return request({
    url: '/uav/route/points/' + routeId,
    method: 'put',
    data: { routePoints }
  })
}
