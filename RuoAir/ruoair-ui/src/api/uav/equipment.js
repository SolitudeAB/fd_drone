import request from '@/utils/request'

// 查询无人机设备列表
export function listEquipment(query) {
  return request({
    url: '/uav/equipment/list',
    method: 'get',
    params: query
  })
}

// 查询无人机设备详细
export function getEquipment(equipmentId) {
  return request({
    url: '/uav/equipment/' + equipmentId,
    method: 'get'
  })
}

// 新增无人机设备
export function addEquipment(data) {
  return request({
    url: '/uav/equipment',
    method: 'post',
    data: data
  })
}

// 修改无人机设备
export function updateEquipment(data) {
  return request({
    url: '/uav/equipment',
    method: 'put',
    data: data
  })
}

// 删除无人机设备
export function delEquipment(equipmentId) {
  return request({
    url: '/uav/equipment/' + equipmentId,
    method: 'delete'
  })
}
