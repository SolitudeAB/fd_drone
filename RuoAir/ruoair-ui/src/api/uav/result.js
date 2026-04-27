import request from '@/utils/request'
import axios from 'axios'
import { getToken } from '@/utils/auth'

const BASE_API = process.env.VUE_APP_BASE_API

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

// AI识别结果图片
export function recognizeResult(resultId) {
  return request({
    url: '/uav/result/recognize/' + resultId,
    method: 'post'
  })
}

// 检查AI接口状态
export function checkAiStatus() {
  return request({
    url: '/uav/result/recognize/status',
    method: 'get'
  })
}

// 导出巡防报告PDF
export function exportReport(resultId) {
  return request({
    url: '/uav/result/report/' + resultId,
    method: 'get',
    responseType: 'blob'
  })
}

// 上传巡防图片
export function uploadResultImage(formData) {
  const uploadAxios = axios.create()
  delete uploadAxios.defaults.headers['Content-Type']
  return uploadAxios.post(BASE_API + '/uav/result/uploadImage', formData, {
    headers: {
      Authorization: 'Bearer ' + getToken()
    }
  }).then(res => res.data)
}

// AI自动分析图片
export function autoAnalyze(imageUrl, taskName) {
  return request({
    url: '/uav/result/autoAnalyze',
    method: 'post',
    data: { imageUrl, taskName }
  })
}
