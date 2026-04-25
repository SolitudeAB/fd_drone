import request from '@/utils/request'

// 查询巡航任务列表
export function listTask(query) {
  return request({
    url: '/uav/task/list',
    method: 'get',
    params: query
  })
}

// 查询巡航任务详细
export function getTask(taskId) {
  return request({
    url: '/uav/task/' + taskId,
    method: 'get'
  })
}

// 新增巡航任务
export function addTask(data) {
  return request({
    url: '/uav/task',
    method: 'post',
    data: data
  })
}

// 修改巡航任务
export function updateTask(data) {
  return request({
    url: '/uav/task',
    method: 'put',
    data: data
  })
}

// 删除巡航任务
export function delTask(taskId) {
  return request({
    url: '/uav/task/' + taskId,
    method: 'delete'
  })
}
