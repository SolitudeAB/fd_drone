import request from '@/utils/request'

// 查询巡航结果列表
export function listResult(query) {
  return request({
    url: '/uav/result/list',
    method: 'get',
    params: query
  })
}

// 查询巡航结果详细
export function getResult(resultId) {
  return request({
    url: '/uav/result/' + resultId,
    method: 'get'
  })
}

// 新增巡航结果
export function addResult(data) {
  return request({
    url: '/uav/result',
    method: 'post',
    data: data
  })
}

// 修改巡航结果
export function updateResult(data) {
  return request({
    url: '/uav/result',
    method: 'put',
    data: data
  })
}

// 删除巡航结果
export function delResult(resultId) {
  return request({
    url: '/uav/result/' + resultId,
    method: 'delete'
  })
}
