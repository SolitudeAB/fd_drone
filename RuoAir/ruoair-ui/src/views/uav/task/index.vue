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
      <el-table-column label="任务ID" align="center" prop="taskId" />
      <el-table-column label="任务名称" align="center" prop="taskName" />
      <el-table-column label="设备ID" align="center" prop="equipmentId" />
      <el-table-column label="航线ID" align="center" prop="routeId" />
      <el-table-column label="任务状态" align="center" prop="taskStatus">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_uav_task_status" :value="scope.row.taskStatus"/>
        </template>
      </el-table-column>
      <el-table-column label="开始时间" align="center" prop="startTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.startTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-map-location"
            @click="handleViewMap(scope.row)"
          >查看航线</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['uav:task:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['uav:task:remove']"
          >删除</el-button>
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

    <!-- 添加或修改巡航任务对话框 -->
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
            <el-form-item label="开始时间" prop="startTime">
              <el-date-picker clearable
                v-model="form.startTime"
                type="date"
                value-format="yyyy-MM-dd"
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
import { listTask, getTask, delTask, addTask, updateTask } from "@/api/uav/task"
// 1. 确保引入了航线的 API（用于根据 ID 查询坐标）和高德 Loader
import { getRoute } from "@/api/uav/route"; // 根据你的实际路径调整
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
      },

      // --- 新增：地图回显相关变量 ---
      mapOpen: false,           // 控制地图弹窗显示/隐藏
      echoMap: null,            // 回显地图实例
      currentTaskName: '',      // 当前查看的任务名称
      currentRoutePoints: '',   // 当前需要回显的坐标数据
    }
  },
  created() {
    this.getList()
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
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        taskId: null,
        taskName: null,
        equipmentId: null,
        routeId: null,
        taskStatus: null,
        startTime: null,
        endTime: null,
        createBy: null,
        createTime: null,
        updateBy: null,
        updateTime: null,
        remark: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.daterangeStartTime = []
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.taskId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加巡航任务"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const taskId = row.taskId || this.ids
      getTask(taskId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航任务"
      })
    },
    /** 提交按钮 */
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
    /** 删除按钮操作 */
    handleDelete(row) {
      const taskIds = row.taskId || this.ids
      this.$modal.confirm('是否确认删除巡航任务编号为"' + taskIds + '"的数据项？').then(function() {
        return delTask(taskIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('uav/task/export', {
        ...this.queryParams
      }, `task_${new Date().getTime()}.xlsx`)
    },
    /** 1. 点击“查看航线”按钮触发 */
    handleViewMap(row) {
      if (!row.routeId) {
        this.$modal.msgWarning("该任务未绑定航线！");
        return;
      }

      this.currentTaskName = row.taskName;

      // 调用 API 根据 route_id 查询航线详情，获取 JSON 坐标
      getRoute(row.routeId).then(response => {
        const routeData = response.data;
        if (!routeData.routePoints) {
          this.$modal.msgWarning("绑定的航线暂无坐标数据，无法预览！");
          return;
        }
        // 赋值坐标并打开弹窗
        this.currentRoutePoints = routeData.routePoints;
        this.mapOpen = true; // 打开弹窗会触发 @opened="initEchoMap"
      });
    },

    /** 2. 初始化回显地图 */
    initEchoMap() {
      // 如果地图已经实例化，直接重画折线即可
      if (this.echoMap) {
        this.drawEchoRoute();
        return;
      }

      AMapLoader.load({
        key: "3e12b539ccc9cec93cc71e8ce8a65306", // 填入你的 API Key
        version: "2.0",
        plugins: ['AMap.Polyline'] // 只需要折线插件即可
      }).then((AMap) => {
        // 实例化地图
        this.echoMap = new AMap.Map("map-echo-container", {
          zoom: 14,
          center: [116.397428, 39.90923] // 默认中心点
        });

        // 地图加载完后，立刻开始画线
        this.drawEchoRoute();

      }).catch(e => {
        console.error("回显地图加载失败:", e);
      });
    },

    /** 3. 核心画线逻辑：解析 JSON 并渲染折线与带序号的钉子 */
    drawEchoRoute() {
      if (!this.echoMap || !this.currentRoutePoints) return;

      // 画新线前，清空旧线和旧钉子
      this.echoMap.clearMap();

      try {
        const path = JSON.parse(this.currentRoutePoints);

        if (path && path.length > 0) {
          // ================= 1. 画折线 =================
          const polyline = new window.AMap.Polyline({
            path: path,
            strokeColor: "#FF33FF", // 品红色，代表任务轨迹
            strokeWeight: 6,
            strokeOpacity: 0.8,
            lineJoin: 'round',
            showDir: true           // 显示方向箭头
          });
          this.echoMap.add(polyline);

          // ================= 2. 画带序号的钉子 =================
          // 遍历坐标数组，在每个点位放置一个自定义的 Marker
          path.forEach((point, index) => {
            const marker = new window.AMap.Marker({
              position: point, // 当前转折点的坐标
              map: this.echoMap,
              anchor: 'bottom-center',
              label: {
                content: `<div style="padding: 0 4px; color: #409EFF; font-weight: bold;">${index + 1}</div>`,
                direction: 'right'
              },
              zIndex: 100       // 保证钉子显示在折线的上方
            });
            // 将钉子加到地图上
            this.echoMap.add(marker);
          });

          // 自动平移和缩放地图视野
          this.echoMap.setFitView();
        }
      } catch (e) {
        console.error("解析航线坐标数据失败:", e);
        this.$modal.msgError("航线数据格式异常无法渲染");
      }
    },
    // 禁用今天之前的日期（保留今天及以后的日期可选）
    disabledDate(time) {
      // 禁用今天之前的日期（保留今天及以后的日期可选）
      return time.getTime() < Date.now() - 8.64e7;
    },
  }
}
</script>
