<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="任务名称" prop="taskName">
        <el-input
          v-model="queryParams.taskName"
          placeholder="请输入任务名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="设备ID" prop="equipmentId">
        <el-input
          v-model="queryParams.equipmentId"
          placeholder="请输入设备ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="航线ID" prop="routeId">
        <el-input
          v-model="queryParams.routeId"
          placeholder="请输入航线ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务状态" prop="taskStatus">
        <el-select v-model="queryParams.taskStatus" placeholder="请选择任务状态" clearable>
          <el-option
            v-for="dict in dict.type.sys_uav_task_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
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
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['uav:task:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['uav:task:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['uav:task:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['uav:task:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="taskList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="任务ID" align="center" prop="taskId" width="60" />
      <el-table-column label="任务名称" align="center" prop="taskName" :show-overflow-tooltip="true" />
      <el-table-column label="设备ID" align="center" prop="equipmentId" width="80" />
      <el-table-column label="航线ID" align="center" prop="routeId" width="80" />
      <el-table-column label="任务状态" align="center" prop="taskStatus" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_uav_task_status" :value="scope.row.taskStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="开始时间" align="center" prop="startTime" width="160">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="执行人" align="center" prop="executor" width="100" />
      <el-table-column label="进度" align="center" prop="progress" width="120">
        <template slot-scope="scope">
          <el-progress
            :percentage="formatProgress(scope.row.progress)"
            :status="formatProgress(scope.row.progress) === 100 ? 'success' : undefined"
            :stroke-width="8"
          />
        </template>
      </el-table-column>

      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="260">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-map-location" @click="handleViewMap(scope.row)">航线</el-button>

          <template v-if="scope.row.taskStatus === '0'">
            <el-button size="mini" type="text" icon="el-icon-video-play" style="color: #67C23A;" @click="handleStart(scope.row)">开始</el-button>
            <el-button size="mini" type="text" icon="el-icon-close" style="color: #F56C6C;" @click="handleCancel(scope.row)">取消</el-button>
            <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['uav:task:edit']">修改</el-button>
          </template>

          <template v-if="scope.row.taskStatus === '1'">
            <el-button size="mini" type="text" icon="el-icon-video-play" style="color: #67C23A;" @click="handleStart(scope.row)">
              {{ isTaskPaused(scope.row) ? '继续' : '开始' }}
            </el-button>
            <el-button size="mini" type="text" icon="el-icon-video-pause" style="color: #E6A23C;" @click="handleCancel(scope.row)">暂停</el-button>
            <el-button size="mini" type="text" icon="el-icon-data-line" style="color: #409EFF;" @click="handleMonitor(scope.row)">监控</el-button>
            <el-button size="mini" type="text" icon="el-icon-circle-check" style="color: #E6A23C;" @click="handleComplete(scope.row)">完成</el-button>
          </template>

          <el-button v-if="scope.row.taskStatus === '2' || scope.row.taskStatus === '3'" size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['uav:task:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog title="航线轨迹预览" :visible.sync="mapOpen" width="800px" append-to-body @opened="initEchoMap">
      <div style="margin-bottom: 10px; color: #606266; font-size: 14px;">
        <strong>当前任务：</strong>{{ currentTaskName }}
      </div>
      <div id="map-echo-container" style="width: 100%; height: 450px; border: 1px solid #DCDFE6; border-radius: 4px;"></div>
    </el-dialog>

    <el-dialog title="无人机巡航模拟监控" :visible.sync="simulationOpen" width="850px" append-to-body @close="closeSimulation">
      <div class="monitor-dashboard" style="margin-bottom: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
        <el-row :gutter="20">
          <el-col :span="12">
            <span style="font-weight: bold; font-size: 14px;">
              任务名称: {{ currentSimulationTask.taskName }}<br/>
              任务进度: <span style="color: #409EFF; font-size: 18px;">{{ formatProgress(progress) }}%</span>
            </span>
            <el-progress :percentage="formatProgress(progress)" :show-text="false" :status="formatProgress(progress) === 100 ? 'success' : undefined" :stroke-width="15" style="margin-top: 10px;"></el-progress>
          </el-col>
          <el-col :span="12" style="text-align: right;">
            <div style="font-size: 13px; color: #606266; margin-bottom: 10px;">
              实际起飞时间: {{ parseTime(currentSimulationTask.startTime) || '暂无数据' }}
            </div>
            <div style="font-size: 14px;">
              预计剩余时间:
              <span style="color: #F56C6C; font-weight: bold; font-size: 22px;">
                {{ remainTime }}
              </span> 分钟
            </div>
          </el-col>
        </el-row>
      </div>
      <div id="map-simulation-container" style="width: 100%; height: 450px; border: 1px solid #DCDFE6; border-radius: 4px;"></div>
    </el-dialog>

    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="任务名称" prop="taskName">
              <el-input v-model="form.taskName" placeholder="请输入任务名称" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="设备ID" prop="equipmentId">
              <el-input v-model="form.equipmentId" placeholder="请输入设备ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="航线ID" prop="routeId">
              <el-input v-model="form.routeId" placeholder="请输入航线ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="任务状态" prop="taskStatus">
              <el-select v-model="form.taskStatus" placeholder="请选择任务状态">
                <el-option
                  v-for="dict in dict.type.sys_uav_task_status"
                  :key="dict.value"
                  :label="dict.label"
                  :value="dict.value"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="执行人" prop="executor">
              <el-input v-model="form.executor" placeholder="请输入执行人" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="开始时间" prop="startTime">
              <el-date-picker clearable
                              v-model="form.startTime"
                              type="datetime"
                              value-format="yyyy-MM-dd HH:mm:ss"
                              placeholder="请选择开始时间"
                              :disabled-date="disabledDate">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
// 注意补充了 startTask, completeTask, cancelTask
import { listTask, getTask, delTask, addTask, updateTask, startTask, completeTask, cancelTask } from "@/api/uav/task"
import { getRoute } from "@/api/uav/route";
import AMapLoader from '@amap/amap-jsapi-loader';

export default {
  name: "Task",
  dicts: ['sys_uav_task_status'],
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 巡航任务表格数据
      taskList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 备注时间范围
      daterangeStartTime: [],
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        taskName: null,
        equipmentId: null,
        routeId: null,
        taskStatus: null,
        startTime: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        taskName: [
          { required: true, message: "任务名称不能为空", trigger: "blur" }
        ],
        equipmentId: [
          { required: true, message: "设备ID不能为空", trigger: "blur" }
        ],
        routeId: [
          { required: true, message: "航线ID不能为空", trigger: "blur" }
        ],
        taskStatus: [
          { required: true, message: "任务状态不能为空", trigger: "change" }
        ],
        startTime: [
          { required: true, message: "开始时间不能为空", trigger: "change" }
        ]
      },

      // --- 原有：地图回显相关变量 ---
      mapOpen: false,
      echoMap: null,
      currentTaskName: '',
      currentRoutePoints: '',

      // --- 新增：模拟监控相关变量 ---
      simulationOpen: false,    // 控制模拟监控弹窗显示
      simulationMap: null,      // 模拟监控的高德地图实例
      uavMarker: null,          // 无人机图标实例
      simulationTimer: null,    // 进度计算定时器
      currentSimulationTask: {},// 当前正在监控的任务详情
      progress: 0,              // 实时进度百分比
      progressExact: 0,         // 实时精确进度（用于轨迹计算）
      remainTime: 0,            // 预计剩余时间(分钟)
      simulationPath: [],
      simulationPaused: false,
      hasSimulationStarted: false,
      pausedTaskMap: {},
      simulationStartTimestamp: 0,
      simulationDurationMs: 0,
      pauseStartedAt: null,
      totalPausedMs: 0,
      lastSimulationTaskId: null,
      lastSyncedProgress: -1,
      movementStartAt: 0,
      movementBaseProgress: 0,
      movementDurationMs: 0,
    }
  },
  created() {
    this.getList()
  },
  // 核心防止内存泄漏：组件销毁前清理定时器
  beforeDestroy() {
    if (this.simulationTimer) {
      clearInterval(this.simulationTimer);
    }
  },
  methods: {
    /** 查询巡航任务列表 */
    getList() {
      this.loading = true
      this.queryParams.params = {}
      if (null != this.daterangeStartTime && '' != this.daterangeStartTime) {
        this.queryParams.params["beginStartTime"] = this.daterangeStartTime[0]
        this.queryParams.params["endStartTime"] = this.daterangeStartTime[1]
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
        equipmentId: null,
        routeId: null,
        taskStatus: "0",
        startTime: null,
        endTime: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null,
        executor: null,
        progress: 0,
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
      const taskId = row.taskId || this.ids
      getTask(taskId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航任务"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.taskId != null) {
            updateTask(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addTask(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    handleDelete(row) {
      const taskIds = row.taskId || this.ids
      this.$modal.confirm('是否确认删除任务编号为"' + taskIds + '"的数据项？').then(function() {
        return delTask(taskIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('uav/task/export', {
        ...this.queryParams
      }, `task_${new Date().getTime()}.xlsx`)
    },
    handleViewMap(row) {
      if (!row.routeId) {
        this.$modal.msgWarning("该任务未绑定航线！");
        return;
      }
      this.currentTaskName = row.taskName;
      getRoute(row.routeId).then(response => {
        const routeData = response.data;
        if (!routeData.routePoints) {
          this.$modal.msgWarning("绑定的航线暂无坐标数据，无法预览！");
          return;
        }
        this.currentRoutePoints = routeData.routePoints;
        this.mapOpen = true;
      });
    },
    initEchoMap() {
      if (this.echoMap) {
        this.drawEchoRoute();
        return;
      }
      AMapLoader.load({
        key: "3e12b539ccc9cec93cc71e8ce8a65306",
        version: "2.0",
        plugins: ['AMap.Polyline']
      }).then((AMap) => {
        this.echoMap = new AMap.Map("map-echo-container", {
          zoom: 14,
          center: [116.397428, 39.90923]
        });
        this.drawEchoRoute();
      }).catch(e => {
        console.error("回显地图加载失败:", e);
      });
    },
    drawEchoRoute() {
      if (!this.echoMap || !this.currentRoutePoints) return;
      this.echoMap.clearMap();
      try {
        const path = JSON.parse(this.currentRoutePoints);
        if (path && path.length > 0) {
          const polyline = new window.AMap.Polyline({
            path: path,
            strokeColor: "#FF33FF",
            strokeWeight: 6,
            strokeOpacity: 0.8,
            lineJoin: 'round',
            showDir: true
          });
          this.echoMap.add(polyline);
          path.forEach((point, index) => {
            const marker = new window.AMap.Marker({
              position: point,
              map: this.echoMap,
              anchor: 'bottom-center',
              label: {
                content: `<div style="padding: 0 4px; color: #409EFF; font-weight: bold;">${index + 1}</div>`,
                direction: 'right'
              },
              zIndex: 100
            });
            this.echoMap.add(marker);
          });
          this.echoMap.setFitView();
        }
      } catch (e) {
        console.error("解析航线坐标数据失败:", e);
        this.$modal.msgError("航线数据格式异常无法渲染");
      }
    },
    disabledDate(time) {
      return time.getTime() < Date.now() - 8.64e7;
    },

    // ==========================================================
    // ================== 新增：核心业务流转控制 ==================
    // ==========================================================

    isTaskPaused(row) {
      return !!this.pausedTaskMap[row.taskId];
    },
    /** 状态扭转：开始执行任务/继续模拟 */
    handleStart(row) {
      if (row.taskStatus === "1") {
        if (this.simulationOpen && this.currentSimulationTask && this.currentSimulationTask.taskId === row.taskId && this.simulationPaused) {
          this.startOrResumeSimulation();
          return;
        }
        this.openSimulation(row, true);
        return;
      }
      this.$modal.confirm('确认要开始执行任务【' + row.taskName + '】吗？').then(() => {
        return startTask(row.taskId);
      }).then(() => {
        return getTask(row.taskId);
      }).then((response) => {
        const latestTask = response.data;
        this.getList();
        this.$modal.msgSuccess("无人机已起飞，任务启动成功");
        this.openSimulation(latestTask, true);
      }).catch(() => {});
    },

    /** 状态扭转：手动完成任务 */
    handleComplete(row) {
      this.$modal.confirm('确认任务【' + row.taskName + '】已完成，并生成巡防结果归档吗？').then(function() {
        return completeTask(row.taskId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("任务已完成并归档");
      }).catch(() => {});
    },

    /** 状态扭转：暂停模拟/取消任务 */
    handleCancel(row) {
      if (row.taskStatus === "1") {
        if (this.simulationOpen && this.currentSimulationTask && this.currentSimulationTask.taskId === row.taskId) {
          this.pauseSimulation(row.taskId);
        } else {
          this.openSimulation(row, true, true);
        }
        return;
      }
      this.$modal.confirm('确认取消该任务？相关设备将被释放，且不生成结果记录。').then(function() {
        return cancelTask(row.taskId);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("任务已取消");
      }).catch(() => {});
    },

    // ==========================================================
    // ================== 新增：全真模拟与进度算力 ==================
    // ==========================================================

    /** 点击【模拟监控】按钮触发 */
    handleMonitor(row) {
      this.openSimulation(row, false);
    },
    openSimulation(row, autoStart, pauseImmediately = false) {
      if (!row.routeId || !row.startTime) {
        this.$modal.msgWarning("任务尚未开始或未绑定航线，无法模拟！");
        return;
      }
      getTask(row.taskId).then((taskResp) => {
        const latestTask = taskResp.data || row;
        this.currentSimulationTask = latestTask;
        this.progressExact = this.normalizeProgress(Number(latestTask.progress || 0));
        this.progress = this.formatProgress(this.progressExact);
        this.updateLocalTaskProgress(latestTask.taskId, this.progress);
        return getRoute(latestTask.routeId);
      }).then(response => {
        const routeData = response.data;
        if (!routeData.routePoints) {
          this.$modal.msgWarning("该航线暂无坐标数据，无法加载地图！");
          return;
        }

        this.currentSimulationTask.estimatedTime = routeData.estimatedTime || 10;
        this.simulationDurationMs = this.currentSimulationTask.estimatedTime * 60 * 1000;
        this.simulationPath = JSON.parse(routeData.routePoints);
        if (!Array.isArray(this.simulationPath) || this.simulationPath.length === 0) {
          this.$modal.msgWarning("该航线坐标为空，无法模拟！");
          return;
        }
        this.prepareSimulationState(autoStart);
        this.simulationOpen = true;
        this.$nextTick(() => {
          this.initSimulationMap().then(() => {
            if (autoStart) {
              this.startOrResumeSimulation();
              if (pauseImmediately) {
                setTimeout(() => this.pauseSimulation(row.taskId), 200);
              }
            } else {
              this.hasSimulationStarted = false;
              this.simulationPaused = false;
              this.refreshRemainTime();
            }
          });
        });
      }).catch(() => {
        this.$modal.msgError("监控数据获取失败");
      });
    },
    prepareSimulationState() {
      const sameTask = this.currentSimulationTask.taskId
        && this.currentSimulationTask.taskId === this.lastSimulationTaskId
        && this.hasSimulationStarted;
      if (!sameTask) {
        this.hasSimulationStarted = false;
        this.simulationPaused = false;
        this.pauseStartedAt = null;
        this.totalPausedMs = 0;
        this.lastSyncedProgress = -1;
      }
      this.simulationStartTimestamp = new Date(this.currentSimulationTask.startTime).getTime();
      this.lastSimulationTaskId = this.currentSimulationTask.taskId;
    },

    /** 算力引擎：动态推算进度与剩余时间 */
    calculateLiveProgress(task) {
      if (this.simulationTimer) clearInterval(this.simulationTimer);
      if (!this.hasSimulationStarted) {
        this.refreshRemainTime();
        this.updateLocalTaskProgress(this.currentSimulationTask.taskId, this.progress);
        return;
      }
      if (this.simulationPaused) {
        this.refreshRemainTime();
        return;
      }
      const tick = () => {
        if (this.movementDurationMs <= 0) {
          this.progressExact = 100;
        } else {
          const elapsed = new Date().getTime() - this.movementStartAt;
          const delta = (elapsed / this.movementDurationMs) * (100 - this.movementBaseProgress);
          this.progressExact = this.normalizeProgress(this.movementBaseProgress + delta);
        }
        this.progress = this.formatProgress(this.progressExact);
        this.refreshRemainTime();
        this.updateLocalTaskProgress(this.currentSimulationTask.taskId, this.progress);
        this.syncTaskProgress(this.progress, false);
        if (this.progress >= 100) {
          this.progress = 100;
          this.syncTaskProgress(100, true);
          clearInterval(this.simulationTimer);
          this.simulationTimer = null;
          this.simulationPaused = false;
          this.pausedTaskMap[this.currentSimulationTask.taskId] = false;
        }
      };
      tick();
      this.simulationTimer = setInterval(tick, 1000);
    },

    /** 初始化模拟地图与高德动画 */
    initSimulationMap() {
      return AMapLoader.load({
        key: "3e12b539ccc9cec93cc71e8ce8a65306",
        version: "2.0",
        plugins: ['AMap.Polyline', 'AMap.Marker', 'AMap.MoveAnimation']
      }).then((AMap) => {
        if (!this.simulationMap) {
          this.simulationMap = new AMap.Map("map-simulation-container", {
            zoom: 15,
          });
        } else {
          this.simulationMap.clearMap();
        }

        try {
          const path = this.simulationPath;
          if (path.length === 0) return;
          const polyline = new AMap.Polyline({
            path: path,
            strokeColor: "#409EFF",
            strokeWeight: 6,
            showDir: true
          });
          this.simulationMap.add(polyline);
          this.simulationMap.setFitView();

          const droneIconSvg = "data:image/svg+xml;charset=UTF-8," + encodeURIComponent(
            "<svg xmlns='http://www.w3.org/2000/svg' width='40' height='40' viewBox='0 0 40 40'><circle cx='20' cy='20' r='19' fill='#409EFF' fill-opacity='0.12'/><path d='M20 3l4 9 9 4-9 4-4 17-4-17-9-4 9-4z' fill='#409EFF' stroke='#1F2D3D' stroke-width='1.2'/><path d='M10 16h20' stroke='#67C23A' stroke-width='2' stroke-linecap='round'/><circle cx='20' cy='20' r='2.2' fill='#67C23A'/></svg>"
          );
          const droneIcon = new AMap.Icon({
            image: droneIconSvg,
            size: new AMap.Size(40, 40),
            imageSize: new AMap.Size(40, 40)
          });

          this.uavMarker = new AMap.Marker({
            map: this.simulationMap,
            position: this.getPositionByProgress(path, this.progressExact),
            icon: droneIcon,
            extData: { taskId: this.currentSimulationTask.taskId },
            anchor: "center",
            offset: new AMap.Pixel(0, 0)
          });
        } catch (e) {
          console.error("加载模拟路线失败", e);
        }
      }).catch((e) => {
        console.error("加载模拟地图失败", e);
      });
    },
    startOrResumeSimulation() {
      if (!this.uavMarker || !this.simulationPath.length) return;
      this.progressExact = this.normalizeProgress(this.progressExact);
      this.progress = this.formatProgress(this.progressExact);
      if (this.progressExact >= 100) {
        this.refreshRemainTime();
        return;
      }
      const remainingPath = this.buildRemainingPath(this.simulationPath, this.progressExact);
      if (remainingPath.length < 2) {
        this.progressExact = 100;
        this.progress = 100;
        this.refreshRemainTime();
        this.syncTaskProgress(100, true);
        return;
      }
      if (typeof this.uavMarker.stopMove === "function") {
        this.uavMarker.stopMove();
      }
      this.uavMarker.setPosition(remainingPath[0]);
      this.movementBaseProgress = this.progressExact;
      this.movementDurationMs = this.simulationDurationMs * (100 - this.progressExact) / 100;
      this.movementStartAt = new Date().getTime();
      this.simulationPaused = false;
      this.hasSimulationStarted = true;
      this.pausedTaskMap[this.currentSimulationTask.taskId] = false;
      this.uavMarker.moveAlong(remainingPath, {
        duration: this.movementDurationMs,
        autoRotation: true,
        easing: function(k) { return k; }
      });
      this.calculateLiveProgress(this.currentSimulationTask);
    },
    pauseSimulation(taskId) {
      if (!this.simulationOpen || !this.currentSimulationTask || this.currentSimulationTask.taskId !== taskId || !this.uavMarker) {
        this.pausedTaskMap[taskId] = true;
        this.$modal.msgWarning("正在打开该任务监控并暂停，请稍候。");
        return;
      }
      if (this.uavMarker && !this.simulationPaused) {
        if (typeof this.uavMarker.stopMove === "function") {
          this.uavMarker.stopMove();
        }
        this.simulationPaused = true;
        this.pauseStartedAt = new Date().getTime();
        this.pausedTaskMap[taskId] = true;
        this.syncTaskProgress(this.progress, true);
        if (this.simulationTimer) {
          clearInterval(this.simulationTimer);
          this.simulationTimer = null;
        }
        this.$modal.msgSuccess("模拟已暂停，再次点击开始可继续");
      }
    },
    updateLocalTaskProgress(taskId, progress) {
      if (!taskId) return;
      const target = this.taskList.find(item => item.taskId === taskId);
      if (target) {
        this.$set(target, "progress", this.formatProgress(progress));
      }
    },
    syncTaskProgress(progress, force) {
      const taskId = this.currentSimulationTask && this.currentSimulationTask.taskId;
      if (!taskId) return;
      const integerProgress = this.formatProgress(progress);
      if (!force && this.lastSyncedProgress >= 0 && Math.abs(integerProgress - this.lastSyncedProgress) < 2) {
        return;
      }
      this.lastSyncedProgress = integerProgress;
      updateTask({ taskId, progress: integerProgress }).then(() => {
        if (force) {
          this.getList();
        }
      }).catch(() => {});
    },
    normalizeProgress(progress) {
      if (Number.isNaN(progress)) return 0;
      if (progress < 0) return 0;
      if (progress > 100) return 100;
      return Number(progress);
    },
    formatProgress(progress) {
      return Math.round(this.normalizeProgress(Number(progress || 0)));
    },
    refreshRemainTime() {
      const remain = this.simulationDurationMs * (100 - this.progressExact) / 100 / 1000 / 60;
      this.remainTime = remain > 0 ? remain.toFixed(1) : 0;
    },
    distanceBetween(a, b) {
      const dx = b[0] - a[0];
      const dy = b[1] - a[1];
      return Math.sqrt(dx * dx + dy * dy);
    },
    getPositionByProgress(path, progress) {
      const p = this.normalizeProgress(progress);
      if (!path || path.length === 0) return [0, 0];
      if (p <= 0) return path[0];
      if (p >= 100) return path[path.length - 1];
      let total = 0;
      const segLens = [];
      for (let i = 1; i < path.length; i++) {
        const len = this.distanceBetween(path[i - 1], path[i]);
        segLens.push(len);
        total += len;
      }
      if (total <= 0) return path[0];
      const target = total * (p / 100);
      let acc = 0;
      for (let i = 1; i < path.length; i++) {
        const len = segLens[i - 1];
        if (acc + len >= target) {
          const ratio = len === 0 ? 0 : (target - acc) / len;
          const start = path[i - 1];
          const end = path[i];
          return [
            start[0] + (end[0] - start[0]) * ratio,
            start[1] + (end[1] - start[1]) * ratio
          ];
        }
        acc += len;
      }
      return path[path.length - 1];
    },
    buildRemainingPath(path, progress) {
      if (!path || path.length === 0) return [];
      const p = this.normalizeProgress(progress);
      if (p <= 0) return [...path];
      if (p >= 100) return [path[path.length - 1]];
      const currentPos = this.getPositionByProgress(path, p);
      let total = 0;
      const segLens = [];
      for (let i = 1; i < path.length; i++) {
        const len = this.distanceBetween(path[i - 1], path[i]);
        segLens.push(len);
        total += len;
      }
      const target = total * (p / 100);
      let acc = 0;
      let segmentEndIndex = 1;
      for (let i = 1; i < path.length; i++) {
        const len = segLens[i - 1];
        if (acc + len >= target) {
          segmentEndIndex = i;
          break;
        }
        acc += len;
      }
      return [currentPos, ...path.slice(segmentEndIndex)];
    },

    /** 关闭监控弹窗时，清理动画与定时器 */
    closeSimulation() {
      this.syncTaskProgress(this.progress, true);
      this.simulationOpen = false;
      if (this.simulationTimer) {
        clearInterval(this.simulationTimer);
        this.simulationTimer = null;
      }
      if (this.uavMarker) {
        this.uavMarker.stopMove(); // 终止高德 Marker 的动画
      }
      this.hasSimulationStarted = false;
      this.simulationPaused = false;
      this.pauseStartedAt = null;
      this.totalPausedMs = 0;
      this.simulationPath = [];
      this.lastSimulationTaskId = null;
      this.lastSyncedProgress = -1;
      this.movementStartAt = 0;
      this.movementBaseProgress = 0;
      this.movementDurationMs = 0;
      this.progressExact = 0;
    }
  }
}
</script>

<style scoped>
.monitor-dashboard .el-progress__text {
  display: none !important;
}
</style>
