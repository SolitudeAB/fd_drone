<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="88px">
      <el-form-item label="结果编号" prop="resultCode">
        <el-input v-model="queryParams.resultCode" placeholder="请输入结果编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="任务名称" prop="taskName">
        <el-input v-model="queryParams.taskName" placeholder="请输入任务名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="设备名称" prop="equipmentName">
        <el-input v-model="queryParams.equipmentName" placeholder="请输入设备名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="执行人" prop="executor">
        <el-input v-model="queryParams.executor" placeholder="请输入执行人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="完成时间">
        <el-date-picker
          v-model="daterangeCompletedTime"
          style="width: 240px"
          value-format="yyyy-MM-dd"
          type="daterange"
          range-separator="-"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['uav:result:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['uav:result:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['uav:result:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['uav:result:export']">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="resultList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="结果编号" align="center" prop="resultCode" min-width="130" />
      <el-table-column label="任务名称" align="center" prop="taskName" min-width="150" show-overflow-tooltip />
      <el-table-column label="设备名称" align="center" prop="equipmentName" min-width="120" />
      <el-table-column label="航线名称" align="center" prop="routeName" min-width="120" />
      <el-table-column label="巡防时长(分钟)" align="center" prop="patrolDuration" width="130" />
      <el-table-column label="完成时间" align="center" prop="completedTime" width="160">
        <template slot-scope="scope">{{ parseTime(scope.row.completedTime) }}</template>
      </el-table-column>
      <el-table-column label="执行人" align="center" prop="executor" width="100" />
      <el-table-column label="巡防概述" align="center" prop="overview" min-width="200" show-overflow-tooltip />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="280">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleDetail(scope.row)">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-map-location" @click="handleViewMap(scope.row)">航线</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['uav:result:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['uav:result:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog title="结果详情" :visible.sync="detailOpen" width="900px" append-to-body>
      <el-descriptions :column="2" border size="small" v-if="detailForm.resultId">
        <el-descriptions-item label="结果编号">{{ detailForm.resultCode }}</el-descriptions-item>
        <el-descriptions-item label="任务名称">{{ detailForm.taskName }}</el-descriptions-item>
        <el-descriptions-item label="设备名称">{{ detailForm.equipmentName }}</el-descriptions-item>
        <el-descriptions-item label="航线名称">{{ detailForm.routeName }}</el-descriptions-item>
        <el-descriptions-item label="执行人">{{ detailForm.executor || '-' }}</el-descriptions-item>
        <el-descriptions-item label="巡防时长">{{ detailForm.patrolDuration || '-' }} 分钟</el-descriptions-item>
        <el-descriptions-item label="完成时间">{{ parseTime(detailForm.completedTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="巡防概述" :span="2">{{ detailForm.overview || '-' }}</el-descriptions-item>
        <el-descriptions-item label="发现情况" :span="2">{{ detailForm.findings || '-' }}</el-descriptions-item>
        <el-descriptions-item label="处理情况" :span="2">{{ detailForm.handlingInfo || '-' }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detailForm.remark || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div v-if="detailForm.aiImageUrl" class="detail-title">图片</div>
      <el-image
        v-if="detailForm.aiImageUrl"
        :src="detailForm.aiImageUrl"
        :preview-src-list="[detailForm.aiImageUrl]"
        fit="cover"
        style="width: 120px; height: 120px; border-radius: 4px;"
      />
    </el-dialog>

    <el-dialog title="航线轨迹预览" :visible.sync="mapOpen" width="800px" append-to-body @opened="initEchoMap">
      <div style="margin-bottom: 10px; color: #606266; font-size: 14px;">
        <strong>当前结果：</strong>{{ currentTaskName }}
      </div>
      <div id="map-echo-container" class="map-box"></div>
    </el-dialog>

    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="结果编号" prop="resultCode">
          <el-input v-model="form.resultCode" placeholder="请输入结果编号" :disabled="form.resultId != null" />
        </el-form-item>
        <el-form-item label="关联任务" prop="taskId">
          <el-select v-model="form.taskId" filterable placeholder="请选择任务" style="width: 100%;" :disabled="form.resultId != null">
            <el-option v-for="item in taskOptions" :key="item.taskId" :label="item.taskName" :value="item.taskId" />
          </el-select>
        </el-form-item>
        <el-form-item label="任务名称">
          <el-input v-model="form.taskName" disabled />
        </el-form-item>
        <el-form-item label="设备名称">
          <el-input v-model="form.equipmentName" disabled />
        </el-form-item>
        <el-form-item label="航线名称">
          <el-input v-model="form.routeName" disabled />
        </el-form-item>
        <el-form-item label="执行人">
          <el-input v-model="form.executor" disabled />
        </el-form-item>
        <el-form-item label="巡防时长">
          <el-input-number v-model="form.patrolDuration" :min="0" :precision="0" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="完成时间" prop="completedTime">
          <el-date-picker v-model="form.completedTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择完成时间" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="巡防概述" prop="overview">
          <el-input v-model="form.overview" type="textarea" :rows="3" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="发现情况" prop="findings">
          <el-input v-model="form.findings" type="textarea" :rows="3" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="处理情况" prop="handlingInfo">
          <el-input v-model="form.handlingInfo" type="textarea" :rows="3" placeholder="请输入处理情况" />
        </el-form-item>
        <el-form-item label="AI识别图片" prop="aiImageUrl">
          <el-input v-model="form.aiImageUrl" placeholder="请输入图片URL" />
        </el-form-item>
        <el-form-item label="备注" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listResult, getResult, delResult, addResult, updateResult } from "@/api/uav/result"
import { listTask, getTask } from "@/api/uav/task"
import { getRoute } from "@/api/uav/route"
import AMapLoader from '@amap/amap-jsapi-loader'

const AMAP_KEY = process.env.VUE_APP_AMAP_KEY || "3e12b539ccc9cec93cc71e8ce8a65306"

export default {
  name: "Result",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      resultList: [],
      title: "",
      open: false,
      detailOpen: false,
      daterangeCompletedTime: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        resultCode: null,
        taskName: null,
        equipmentName: null,
        executor: null
      },
      taskOptions: [],
      form: {},
      detailForm: {},
      rules: {
        resultCode: [{ required: true, message: "结果编号不能为空", trigger: "blur" }],
        taskId: [{ required: true, message: "任务不能为空", trigger: "change" }],
        overview: [{ required: true, message: "巡航概述不能为空", trigger: "blur" }]
      },
      mapOpen: false,
      echoMap: null,
      currentTaskName: '',
      currentRoutePoints: ''
    }
  },
  created() {
    this.getList()
    this.loadTaskOptions()
  },
  watch: {
    'form.taskId'(val) {
      if (!val || this.form.resultId) return
      getTask(val).then(resp => {
        const task = resp.data || {}
        this.form.taskName = task.taskName || ''
        this.form.equipmentName = task.equipmentName || ''
        this.form.routeName = task.routeName || ''
        this.form.executor = task.executor || ''
      })
    }
  },
  methods: {
    loadTaskOptions() {
      listTask({ pageNum: 1, pageSize: 1000 }).then(resp => {
        this.taskOptions = resp.rows || []
      })
    },
    getList() {
      this.loading = true
      this.queryParams.params = {}
      if (this.daterangeCompletedTime && this.daterangeCompletedTime.length === 2) {
        this.queryParams.params.beginCompletedTime = this.daterangeCompletedTime[0]
        this.queryParams.params.endCompletedTime = this.daterangeCompletedTime[1]
      }
      listResult(this.queryParams).then(response => {
        this.resultList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = {
        resultId: null,
        resultCode: null,
        taskId: null,
        taskName: null,
        equipmentName: null,
        routeName: null,
        executor: null,
        patrolDuration: null,
        completedTime: null,
        overview: null,
        findings: null,
        handlingInfo: null,
        aiImageUrl: null,
        routePoints: null,
        remark: null
      }
      this.resetForm("form")
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.daterangeCompletedTime = []
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.resultId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加巡航结果"
    },
    handleUpdate(row) {
      this.reset()
      const resultId = row.resultId || this.ids[0]
      getResult(resultId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航结果"
      })
    },
    handleDetail(row) {
      getResult(row.resultId).then(response => {
        this.detailForm = response.data || {}
        this.detailOpen = true
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const action = this.form.resultId != null ? updateResult : addResult
        action(this.form).then(() => {
          this.$modal.msgSuccess(this.form.resultId != null ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const resultIds = row.resultId || this.ids
      this.$modal.confirm('是否确认删除巡航结果编号为"' + resultIds + '"的数据项？').then(() => {
        return delResult(resultIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('uav/result/export', { ...this.queryParams }, `result_${new Date().getTime()}.xlsx`)
    },
    async handleViewMap(row) {
      this.currentTaskName = row.taskName || `结果-${row.resultCode}`
      try {
        if (row.routePoints) {
          this.currentRoutePoints = row.routePoints
          this.mapOpen = true
          return
        }
        if (!row.taskId) {
          this.$modal.msgWarning("该结果记录未关联任务")
          return
        }
        const taskResponse = await getTask(row.taskId)
        const routeId = taskResponse.data && taskResponse.data.routeId
        if (!routeId) {
          this.$modal.msgWarning("该任务未绑定航线")
          return
        }
        const routeResponse = await getRoute(routeId)
        if (!routeResponse.data || !routeResponse.data.routePoints) {
          this.$modal.msgWarning("该航线暂无坐标点位数据")
          return
        }
        this.currentRoutePoints = routeResponse.data.routePoints
        this.mapOpen = true
      } catch (error) {
        this.$modal.msgError("获取航线数据失败")
      }
    },
    initEchoMap() {
      if (this.echoMap) {
        this.drawEchoRoute()
        return
      }
      AMapLoader.load({
        key: AMAP_KEY,
        version: "2.0",
        plugins: ['AMap.Polyline', 'AMap.Marker']
      }).then((AMap) => {
        this.echoMap = new AMap.Map("map-echo-container", {
          zoom: 14,
          center: [116.397428, 39.90923]
        })
        this.drawEchoRoute()
      }).catch(() => {
        this.$modal.msgError("地图加载失败")
      })
    },
    drawEchoRoute() {
      if (!this.echoMap || !this.currentRoutePoints) return
      this.echoMap.clearMap()
      try {
        const path = JSON.parse(this.currentRoutePoints)
        if (path && path.length > 0) {
          const polyline = new window.AMap.Polyline({
            path,
            strokeColor: "#409EFF",
            strokeWeight: 6,
            strokeOpacity: 0.8,
            lineJoin: 'round',
            showDir: true
          })
          this.echoMap.add(polyline)
          this.echoMap.setFitView()
        }
      } catch (e) {
        this.$modal.msgError("航线轨迹渲染异常")
      }
    }
  }
}
</script>

<style scoped>
.map-box {
  width: 100%;
  height: 450px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
}

.detail-title {
  margin: 16px 0 8px;
  font-weight: 600;
}
</style>
