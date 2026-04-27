<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="82px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input v-model="queryParams.taskName" placeholder="请输入任务名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="执行人" prop="executor">
        <el-input v-model="queryParams.executor" placeholder="请输入执行人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="设备名称" prop="equipmentName">
        <el-input v-model="queryParams.equipmentName" placeholder="请输入设备名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="任务状态" prop="taskStatus">
        <el-select v-model="queryParams.taskStatus" placeholder="请选择任务状态" clearable>
          <el-option v-for="dict in dict.type.sys_uav_task_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="开始时间">
        <el-date-picker
          v-model="daterangeStartTime"
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
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['uav:task:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['uav:task:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['uav:task:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['uav:task:export']">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务名称" align="center" prop="taskName" min-width="150" show-overflow-tooltip />
      <el-table-column label="执行人" align="center" prop="executor" width="100" />
      <el-table-column label="设备名称" align="center" prop="equipmentName" min-width="120" show-overflow-tooltip />
      <el-table-column label="航线名称" align="center" prop="routeName" min-width="120" show-overflow-tooltip />
      <el-table-column label="任务状态" align="center" prop="taskStatus" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.taskStatus === '0' && scope.row.progress > 0" type="warning">已暂停</el-tag>
          <dict-tag v-else :options="dict.type.sys_uav_task_status" :value="scope.row.taskStatus" />
        </template>
      </el-table-column>
      <el-table-column label="开始时间" align="center" prop="startTime" width="160">
        <template slot-scope="scope">{{ parseTime(scope.row.startTime) }}</template>
      </el-table-column>
      <el-table-column label="进度" align="center" prop="progress" width="130">
        <template slot-scope="scope">
          <el-progress :percentage="formatProgress(scope.row.progress)" :status="formatProgress(scope.row.progress) === 100 ? 'success' : undefined" :stroke-width="8" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="420">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleDetail(scope.row)">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-map-location" @click="handleViewMap(scope.row)">航线</el-button>

          <template v-if="scope.row.taskStatus === '0'">
            <el-button size="mini" type="text" icon="el-icon-video-play" style="color: #67C23A;" @click="handleStart(scope.row)">
              {{ scope.row.progress > 0 ? '继续飞行' : '开始' }}
            </el-button>
            <el-button size="mini" type="text" icon="el-icon-close" style="color: #f56c6c;" @click="handleCancel(scope.row)">取消</el-button>

            <el-button v-if="!scope.row.progress || scope.row.progress === 0" size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['uav:task:edit']">修改</el-button>
          </template>

          <template v-if="scope.row.taskStatus === '1'">
            <el-button size="mini" type="text" icon="el-icon-data-line" style="color: #409EFF;" @click="handleMonitor(scope.row)">监控</el-button>
            <el-button size="mini" type="text" icon="el-icon-circle-check" style="color: #67C23A;" @click="handleComplete(scope.row)">完成</el-button>
            <el-button size="mini" type="text" icon="el-icon-close" style="color: #f56c6c;" @click="handleCancel(scope.row)">取消</el-button>
          </template>

          <el-button
            v-if="scope.row.taskStatus === '2' || scope.row.taskStatus === '3'"
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['uav:task:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog title="航线轨迹预览" :visible.sync="mapOpen" width="800px" append-to-body @opened="initEchoMap">
      <div style="margin-bottom: 10px; color: #606266; font-size: 14px;">
        <strong>当前任务：</strong>{{ currentTaskName }}
      </div>
      <div id="map-echo-container" class="map-box"></div>
    </el-dialog>

    <el-dialog title="无人机巡防模拟监控" :visible.sync="simulationOpen" width="850px" append-to-body @close="closeSimulation">
      <div class="monitor-dashboard">
        <el-row :gutter="20">
          <el-col :span="12">
        <span style="font-weight: bold; font-size: 14px;">
          任务名称: {{ currentSimulationTask.taskName }}<br>
          任务进度: <span style="color: #409EFF; font-size: 18px;">{{ formatProgress(progress) }}%</span>
        </span>
            <el-progress :percentage="formatProgress(progress)" :show-text="false" :status="formatProgress(progress) === 100 ? 'success' : undefined" :stroke-width="15" style="margin-top: 10px;" />

            <div style="margin-top: 15px;">
              <el-button v-if="progress < 100 && (simulationPaused || !hasSimulationStarted)" type="primary" size="mini" icon="el-icon-video-play" @click="startOrResumeSimulation()">
                {{ progress > 0 ? '继续飞行' : '开始飞行' }}
              </el-button>
              <el-button v-if="progress < 100 && !simulationPaused && hasSimulationStarted" type="warning" size="mini" icon="el-icon-video-pause" @click="pauseSimulation(currentSimulationTask.taskId)">
                暂停飞行
              </el-button>
              <el-button v-if="progress === 100" type="success" size="mini" icon="el-icon-circle-check" @click="handleComplete(currentSimulationTask)">
                任务到达终点，点击完成归档
              </el-button>
            </div>
          </el-col>
          <el-col :span="12" style="text-align: right;">
            <div style="font-size: 13px; color: #606266; margin-bottom: 10px;">
              实际起飞时间: {{ parseTime(currentSimulationTask.startTime) || '暂无数据' }}
            </div>
            <div style="font-size: 14px;">
              预计剩余时间:
              <span style="color: #F56C6C; font-weight: bold; font-size: 22px;">{{ remainTime }}</span> 分钟
            </div>
          </el-col>
        </el-row>
      </div>
      <div id="map-simulation-container" class="map-box"></div>
    </el-dialog>

    <el-dialog :title="title" :visible.sync="open" width="560px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="任务名称" prop="taskName">
          <el-input v-model="form.taskName" placeholder="请输入任务名称" />
        </el-form-item>
        <el-form-item label="执行人" prop="executor">
          <el-input v-model="form.executor" placeholder="请输入执行人" />
        </el-form-item>
        <el-form-item label="设备" prop="equipmentId">
          <el-select v-model="form.equipmentId" filterable placeholder="请选择设备" style="width: 100%;">
            <el-option v-for="item in equipmentOptions" :key="item.equipmentId" :label="`${item.equipmentName}(${item.equipmentCode})`" :value="item.equipmentId" />
          </el-select>
        </el-form-item>
        <el-form-item label="航线" prop="routeId">
          <el-select v-model="form.routeId" filterable placeholder="请选择航线" style="width: 100%;">
            <el-option v-for="item in routeOptions" :key="item.routeId" :label="item.routeName" :value="item.routeId" />
          </el-select>
        </el-form-item>
        <el-form-item label="开始时间" prop="startTime">
          <el-date-picker
            clearable
            v-model="form.startTime"
            type="datetime"
            value-format="yyyy-MM-dd HH:mm:ss"
            placeholder="请选择开始时间"
            :disabled-date="disabledDate"
            style="width: 100%;"
          />
        </el-form-item>
        <el-form-item label="任务描述" prop="taskDescription">
          <el-input v-model="form.taskDescription" type="textarea" :rows="3" placeholder="请输入任务描述" />
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

    <el-dialog title="任务详情" :visible.sync="detailOpen" width="900px" append-to-body>
      <el-descriptions :column="2" border size="small" v-if="detailForm.taskId">
        <el-descriptions-item label="任务名称">{{ detailForm.taskName }}</el-descriptions-item>
        <el-descriptions-item label="执行人">{{ detailForm.executor || '-' }}</el-descriptions-item>
        <el-descriptions-item label="设备">{{ detailForm.equipmentName || `设备ID:${detailForm.equipmentId}` }}</el-descriptions-item>
        <el-descriptions-item label="航线">{{ detailForm.routeName || `航线ID:${detailForm.routeId}` }}</el-descriptions-item>
        <el-descriptions-item label="任务状态">
          <dict-tag :options="dict.type.sys_uav_task_status" :value="detailForm.taskStatus" />
        </el-descriptions-item>
        <el-descriptions-item label="进度">{{ formatProgress(detailForm.progress) }}%</el-descriptions-item>
        <el-descriptions-item label="开始时间">{{ parseTime(detailForm.startTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="结束时间">{{ parseTime(detailForm.endTime) || '-' }}</el-descriptions-item>
        <el-descriptions-item label="任务描述" :span="2">{{ detailForm.taskDescription || '-' }}</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detailForm.remark || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div class="detail-title">状态变更记录</div>
      <el-table :data="historyRows" size="mini" border>
        <el-table-column label="时间" prop="time" width="180" />
        <el-table-column label="状态" prop="status" width="120" />
        <el-table-column label="操作" prop="action" />
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { listTask, getTask, delTask, addTask, updateTask, startTask, completeTask, cancelTask, pauseTask } from "@/api/uav/task"
import { listEquipment } from "@/api/uav/equipment"
import { listRoute, getRoute } from "@/api/uav/route"
import AMapLoader from '@amap/amap-jsapi-loader'

const AMAP_KEY = process.env.VUE_APP_AMAP_KEY || "3e12b539ccc9cec93cc71e8ce8a65306"

export default {
  name: "Task",
  dicts: ['sys_uav_task_status'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      taskList: [],
      title: "",
      open: false,
      detailOpen: false,
      daterangeStartTime: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        taskName: null,
        executor: null,
        equipmentName: null,
        taskStatus: null
      },
      form: {},
      detailForm: {},
      historyRows: [],
      equipmentOptions: [],
      routeOptions: [],
      rules: {
        taskName: [{ required: true, message: "任务名称不能为空", trigger: "blur" }],
        equipmentId: [{ required: true, message: "请选择设备", trigger: "change" }],
        routeId: [{ required: true, message: "请选择航线", trigger: "change" }],
        startTime: [{ required: true, message: "开始时间不能为空", trigger: "change" }]
      },
      mapOpen: false,
      echoMap: null,
      currentTaskName: '',
      currentRoutePoints: '',
      simulationOpen: false,
      simulationMap: null,
      uavMarker: null,
      simulationTimer: null,
      currentSimulationTask: {},
      progress: 0,
      progressExact: 0,
      remainTime: 0,
      simulationPath: [],
      simulationPaused: false,
      hasSimulationStarted: false,
      pausedTaskMap: {},
      simulationDurationMs: 0,
      movementStartAt: 0,
      movementBaseProgress: 0,
      movementDurationMs: 0,
      lastSyncedProgress: -1,
      simulationCompletionTimer: null
    }
  },
  created() {
    this.getList()
    this.loadOptions()
  },
  beforeDestroy() {
    if (this.simulationTimer) clearInterval(this.simulationTimer)
    if (this.simulationCompletionTimer) clearTimeout(this.simulationCompletionTimer)
  },
  methods: {
    loadOptions() {
      listEquipment({ pageNum: 1, pageSize: 1000 }).then(res => {
        this.equipmentOptions = res.rows || []
      })
      listRoute({ pageNum: 1, pageSize: 1000 }).then(res => {
        this.routeOptions = res.rows || []
      })
    },
    getList() {
      this.loading = true
      this.queryParams.params = {}
      if (this.daterangeStartTime && this.daterangeStartTime.length === 2) {
        this.queryParams.params.beginStartTime = this.daterangeStartTime[0]
        this.queryParams.params.endStartTime = this.daterangeStartTime[1]
      }
      listTask(this.queryParams).then(response => {
        this.taskList = response.rows
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
        taskId: null,
        taskName: null,
        taskDescription: null,
        equipmentId: null,
        routeId: null,
        taskStatus: "0",
        startTime: null,
        executor: null,
        progress: 0,
        remark: null
      }
      this.resetForm("form")
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.daterangeStartTime = []
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.taskId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加巡航任务"
    },
    handleUpdate(row) {
      this.reset()
      const taskId = row.taskId || this.ids[0]
      getTask(taskId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航任务"
      })
    },
    handleDetail(row) {
      getTask(row.taskId).then(response => {
        this.detailForm = response.data || {}
        this.historyRows = this.parseStatusHistory(this.detailForm.statusHistory)
        this.detailOpen = true
      })
    },
    parseStatusHistory(raw) {
      if (!raw) return []
      return raw.split('\n').filter(Boolean).map(line => {
        const [time, status, action] = line.split('|')
        return { time, status, action }
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const action = this.form.taskId != null ? updateTask : addTask
        action(this.form).then(() => {
          this.$modal.msgSuccess(this.form.taskId != null ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const taskIds = row.taskId || this.ids
      this.$modal.confirm('是否确认删除任务编号为"' + taskIds + '"的数据项？').then(() => {
        return delTask(taskIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('uav/task/export', { ...this.queryParams }, `task_${new Date().getTime()}.xlsx`)
    },
    handleStart(row) {
      this.$modal.confirm('确认要开始执行任务【' + row.taskName + '】吗？').then(() => {
        return startTask(row.taskId)
      }).then(() => {
        this.$modal.msgSuccess("任务启动成功")
        this.getList()
        this.openSimulation({ ...row, taskStatus: "1" }, true)
      }).catch(() => {})
    },
    handleComplete(row) {
      this.$modal.confirm('确认任务【' + row.taskName + '】已完成，并生成巡防结果归档吗？').then(() => {
        return completeTask(row.taskId);
      }).then(() => {
        this.$modal.msgSuccess("任务已完成并归档");
        this.getList();
        // 如果是在弹窗里点击的完成，自动关闭弹窗
        if (this.simulationOpen && this.isSameTask(this.currentSimulationTask.taskId, row.taskId)) {
          this.closeSimulation();
        }
      }).catch(() => {});
    },
    handleCancel(row) {
      this.$modal.confirm('确认取消任务【' + row.taskName + '】吗？取消后不生成巡防结果。').then(() => {
        return cancelTask(row.taskId)
      }).then(() => {
        this.$modal.msgSuccess("任务已取消")
        this.getList()
        if (this.isSameTask(this.currentSimulationTask.taskId, row.taskId)) this.closeSimulation()
      }).catch(() => {})
    },
    handleViewMap(row) {
      if (!row.routeId) {
        this.$modal.msgWarning("该任务未绑定航线")
        return
      }
      this.currentTaskName = row.taskName
      getRoute(row.routeId).then(response => {
        const routeData = response.data || {}
        if (!routeData.routePoints) {
          this.$modal.msgWarning("绑定航线暂无坐标数据")
          return
        }
        this.currentRoutePoints = routeData.routePoints
        this.mapOpen = true
      })
    },
    initEchoMap() {
      if (this.echoMap) {
        this.drawEchoRoute()
        return
      }
      AMapLoader.load({ key: AMAP_KEY, version: "2.0", plugins: ['AMap.Polyline', 'AMap.Marker'] }).then((AMap) => {
        this.echoMap = new AMap.Map("map-echo-container", { zoom: 14, center: [116.397428, 39.90923] })
        this.drawEchoRoute()
      })
    },
    drawEchoRoute() {
      if (!this.echoMap || !this.currentRoutePoints) return
      this.echoMap.clearMap()
      try {
        const path = JSON.parse(this.currentRoutePoints)
        if (!path || !path.length) return
        const polyline = new window.AMap.Polyline({ path, strokeColor: "#409EFF", strokeWeight: 6, showDir: true })
        this.echoMap.add(polyline)
        this.echoMap.setFitView()
      } catch (e) {
        this.$modal.msgError("航线数据格式异常")
      }
    },
    handleMonitor(row) {
      this.openSimulation(row, true); // 传 true 意味着打开弹窗后自动开始/继续动画
    },
    resumeSimulation(row) {
      this.openSimulation(row, true)
    },
    openSimulation(row, autoStart) {
      getTask(row.taskId).then(taskResp => {
        const latestTask = taskResp.data || row
        this.currentSimulationTask = latestTask
        this.progressExact = this.normalizeProgress(Number(latestTask.progress || 0))
        this.progress = this.formatProgress(this.progressExact)
        return getRoute(latestTask.routeId)
      }).then(routeResp => {
        const routeData = routeResp.data || {}
        if (!routeData.routePoints) {
          this.$modal.msgWarning("该航线暂无坐标数据，无法加载地图")
          return
        }
        this.currentSimulationTask.estimatedTime = routeData.estimatedTime || 10
        this.simulationDurationMs = this.currentSimulationTask.estimatedTime * 60 * 1000
        this.simulationPath = JSON.parse(routeData.routePoints)
        this.simulationOpen = true
        this.$nextTick(() => {
          this.initSimulationMap().then(() => {
            if (autoStart) this.startOrResumeSimulation()
            else this.refreshRemainTime()
          })
        })
      }).catch(() => {
        this.$modal.msgError("监控数据获取失败")
      })
    },
    initSimulationMap() {
      return AMapLoader.load({
        key: AMAP_KEY,
        version: "2.0",
        plugins: ['AMap.Polyline', 'AMap.Marker', 'AMap.MoveAnimation']
      }).then((AMap) => {
        if (!this.simulationMap) {
          this.simulationMap = new AMap.Map("map-simulation-container", { zoom: 15 })
        } else {
          this.simulationMap.clearMap()
        }
        const path = this.simulationPath
        if (!path || !path.length) return
        const polyline = new AMap.Polyline({ path, strokeColor: "#409EFF", strokeWeight: 6, showDir: true })
        this.simulationMap.add(polyline)
        this.simulationMap.setFitView()

        const droneIconSvg = "data:image/svg+xml;charset=UTF-8," + encodeURIComponent(
          "<svg xmlns='http://www.w3.org/2000/svg' width='40' height='40' viewBox='0 0 40 40'><circle cx='20' cy='20' r='19' fill='#409EFF' fill-opacity='0.12'/><path d='M20 3l4 9 9 4-9 4-4 17-4-17-9-4 9-4z' fill='#409EFF' stroke='#1F2D3D' stroke-width='1.2'/><path d='M10 16h20' stroke='#67C23A' stroke-width='2' stroke-linecap='round'/><circle cx='20' cy='20' r='2.2' fill='#67C23A'/></svg>"
        )
        const droneIcon = new AMap.Icon({ image: droneIconSvg, size: new AMap.Size(40, 40), imageSize: new AMap.Size(40, 40) })
        this.uavMarker = new AMap.Marker({
          map: this.simulationMap,
          position: this.getPositionByProgress(path, this.progressExact),
          icon: droneIcon,
          anchor: "center",
          offset: new AMap.Pixel(0, 0)
        })
      })
    },
    startOrResumeSimulation() {
      if (!this.uavMarker || !this.simulationPath.length) return
      this.progressExact = this.normalizeProgress(this.progressExact)
      this.progress = this.formatProgress(this.progressExact)
      if (this.progressExact >= 100) {
        this.refreshRemainTime()
        return
      }
      if (this.simulationPaused) {
        startTask(this.currentSimulationTask.taskId).then(() => {
          this.currentSimulationTask.taskStatus = "1"
          this.doStartAnimation()
        }).catch(() => {})
      } else {
        this.doStartAnimation()
      }
    },
    doStartAnimation() {
      const remainingPath = this.buildRemainingPath(this.simulationPath, this.progressExact)
      if (remainingPath.length < 2) return
      if (typeof this.uavMarker.stopMove === "function") this.uavMarker.stopMove()
      this.uavMarker.setPosition(remainingPath[0])
      this.movementBaseProgress = this.progressExact
      this.movementDurationMs = this.simulationDurationMs * (100 - this.progressExact) / 100
      this.movementStartAt = new Date().getTime()
      this.simulationPaused = false
      this.hasSimulationStarted = true
      this.pausedTaskMap[this.currentSimulationTask.taskId] = false
      this.uavMarker.moveAlong(remainingPath, {
        duration: this.movementDurationMs,
        autoRotation: true,
        easing: function(k) { return k }
      })
      if (this.simulationCompletionTimer) clearTimeout(this.simulationCompletionTimer)
      this.simulationCompletionTimer = setTimeout(() => {
        this.progressExact = 100
        this.progress = 100
        this.syncTaskProgress(100, true)
        this.updateLocalTaskProgress(this.currentSimulationTask.taskId, 100)
        if (this.simulationTimer) {
          clearInterval(this.simulationTimer)
          this.simulationTimer = null
        }
      }, this.movementDurationMs + 1500)
      this.calculateLiveProgress()
    },
    isTaskPaused(row) {
      return !!this.pausedTaskMap[row.taskId]
    },
    /** 暂停飞行（调用后端暂停接口，改变任务业务状态） */
    pauseSimulation(taskId) {
      if (typeof taskId === 'object') {
        taskId = null
      }

      const targetId = taskId || (this.currentSimulationTask && this.currentSimulationTask.taskId)
      if (!targetId) return

      const finalProgress = this.formatProgress(this.progress)

      if (this.uavMarker && typeof this.uavMarker.stopMove === "function") {
        this.uavMarker.stopMove()
      }
      if (this.simulationTimer) {
        clearInterval(this.simulationTimer)
        this.simulationTimer = null
      }
      if (this.simulationCompletionTimer) {
        clearTimeout(this.simulationCompletionTimer)
        this.simulationCompletionTimer = null
      }
      this.simulationPaused = true
      this.hasSimulationStarted = true
      this.pausedTaskMap[targetId] = true

      this.updateLocalTaskProgress(targetId, finalProgress)
      this.syncTaskProgress(finalProgress, true)

      pauseTask(targetId).then(() => {
        this.currentSimulationTask.taskStatus = "0"
        this.$modal.msgSuccess("飞行已暂停，任务状态已更新")
      }).catch(() => {
        this.$modal.msgSuccess("飞行已暂停（模拟层面）")
      })
    },
    calculateLiveProgress() {
      if (this.simulationTimer) clearInterval(this.simulationTimer)
      const tick = () => {
        if (this.simulationPaused) return
        if (this.movementDurationMs <= 0) {
          this.progressExact = 100
        } else {
          const elapsed = new Date().getTime() - this.movementStartAt
          const delta = (elapsed / this.movementDurationMs) * (100 - this.movementBaseProgress)
          this.progressExact = this.normalizeProgress(this.movementBaseProgress + delta)
        }
        this.progress = this.formatProgress(this.progressExact)
        this.refreshRemainTime()
        this.updateLocalTaskProgress(this.currentSimulationTask.taskId, this.progress)
        this.syncTaskProgress(this.progress, false)
        if (this.progress >= 100) {
          this.progress = 100
          this.syncTaskProgress(100, true)
          clearInterval(this.simulationTimer)
          this.simulationTimer = null
        }
      }
      tick()
      this.simulationTimer = setInterval(tick, 1000)
    },
    updateLocalTaskProgress(taskId, progress) {
      const target = this.taskList.find(item => item.taskId === taskId)
      if (target) this.$set(target, "progress", this.formatProgress(progress))
    },
    syncTaskProgress(progress, force) {
      const taskId = this.currentSimulationTask && this.currentSimulationTask.taskId
      if (!taskId) return
      const integerProgress = this.formatProgress(progress)
      if (!force && this.lastSyncedProgress >= 0 && Math.abs(integerProgress - this.lastSyncedProgress) < 2) return
      this.lastSyncedProgress = integerProgress
      updateTask({ taskId, progress: integerProgress }).then(() => {
        if (force) this.getList()
      }).catch(() => {})
    },
    normalizeProgress(progress) {
      if (Number.isNaN(progress)) return 0
      if (progress < 0) return 0
      if (progress > 100) return 100
      return Number(progress)
    },
    formatProgress(progress) {
      return Math.round(this.normalizeProgress(Number(progress || 0)))
    },
    refreshRemainTime() {
      const remain = this.simulationDurationMs * (100 - this.progressExact) / 100 / 1000 / 60
      this.remainTime = remain > 0 ? remain.toFixed(1) : 0
    },
    distanceBetween(a, b) {
      const dx = b[0] - a[0]
      const dy = b[1] - a[1]
      return Math.sqrt(dx * dx + dy * dy)
    },
    getPositionByProgress(path, progress) {
      const p = this.normalizeProgress(progress)
      if (!path || path.length === 0) return [0, 0]
      if (p <= 0) return path[0]
      if (p >= 100) return path[path.length - 1]
      let total = 0
      const segLens = []
      for (let i = 1; i < path.length; i++) {
        const len = this.distanceBetween(path[i - 1], path[i])
        segLens.push(len)
        total += len
      }
      if (total <= 0) return path[0]
      const target = total * (p / 100)
      let acc = 0
      for (let i = 1; i < path.length; i++) {
        const len = segLens[i - 1]
        if (acc + len >= target) {
          const ratio = len === 0 ? 0 : (target - acc) / len
          const start = path[i - 1]
          const end = path[i]
          return [start[0] + (end[0] - start[0]) * ratio, start[1] + (end[1] - start[1]) * ratio]
        }
        acc += len
      }
      return path[path.length - 1]
    },
    buildRemainingPath(path, progress) {
      if (!path || path.length === 0) return []
      const p = this.normalizeProgress(progress)
      if (p <= 0) return [...path]
      if (p >= 100) return [path[path.length - 1]]
      const currentPos = this.getPositionByProgress(path, p)
      let total = 0
      const segLens = []
      for (let i = 1; i < path.length; i++) {
        const len = this.distanceBetween(path[i - 1], path[i])
        segLens.push(len)
        total += len
      }
      const target = total * (p / 100)
      let acc = 0
      let segmentEndIndex = 1
      for (let i = 1; i < path.length; i++) {
        const len = segLens[i - 1]
        if (acc + len >= target) {
          segmentEndIndex = i
          break
        }
        acc += len
      }
      return [currentPos, ...path.slice(segmentEndIndex)]
    },
    closeSimulation() {
      this.syncTaskProgress(this.progress, true)
      this.simulationOpen = false
      if (this.simulationTimer) {
        clearInterval(this.simulationTimer)
        this.simulationTimer = null
      }
      if (this.simulationCompletionTimer) {
        clearTimeout(this.simulationCompletionTimer)
        this.simulationCompletionTimer = null
      }
      if (this.uavMarker) this.uavMarker.stopMove()
      this.hasSimulationStarted = false
      this.simulationPaused = false
      this.simulationPath = []
      this.lastSyncedProgress = -1
      this.progressExact = 0
      this.progress = 0
    },
    isSameTask(leftTaskId, rightTaskId) {
      if (leftTaskId === undefined || leftTaskId === null || rightTaskId === undefined || rightTaskId === null) {
        return false
      }
      return String(leftTaskId) === String(rightTaskId)
    },
    disabledDate(time) {
      return time.getTime() < Date.now() - 8.64e7
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

.monitor-dashboard {
  margin-bottom: 20px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 8px;
}

.monitor-dashboard .el-progress__text {
  display: none !important;
}

.detail-title {
  margin: 16px 0 8px;
  font-weight: 600;
}
</style>
