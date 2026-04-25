<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="结果编号" prop="resultCode">
        <el-input
          v-model="queryParams.resultCode"
          placeholder="请输入结果编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="任务ID" prop="taskId">
        <el-input
          v-model="queryParams.taskId"
          placeholder="请输入任务ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
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
          v-hasPermi="['uav:result:add']"
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
          v-hasPermi="['uav:result:edit']"
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
          v-hasPermi="['uav:result:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['uav:result:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="resultList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="结果ID" align="center" prop="resultId" />
      <el-table-column label="结果编号" align="center" prop="resultCode" />
      <el-table-column label="任务ID" align="center" prop="taskId" />
      <el-table-column label="巡航概述" align="center" prop="overview" />
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
            v-hasPermi="['uav:result:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['uav:result:remove']"
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

    <!-- 添加或修改巡航结果对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="结果编号" prop="resultCode">
              <el-input v-model="form.resultCode" placeholder="请输入结果编号" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="任务ID" prop="taskId">
              <el-input v-model="form.taskId" placeholder="请输入任务ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="巡航概述" prop="overview">
              <el-input v-model="form.overview" type="textarea" placeholder="请输入内容" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="发现情况" prop="findings">
              <el-input v-model="form.findings" type="textarea" placeholder="请输入内容" />
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
import { listResult, getResult, delResult, addResult, updateResult } from "@/api/uav/result"
import { getTask } from "@/api/uav/task";   // 需引入获取任务的方法
import { getRoute } from "@/api/uav/route"; // 需引入获取航线的方法
import AMapLoader from '@amap/amap-jsapi-loader';

export default {
  name: "Result",
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
      // 巡航结果表格数据
      resultList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        resultCode: null,
        taskId: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        resultCode: [
          { required: true, message: "结果编号不能为空", trigger: "blur" }
        ],
        taskId: [
          { required: true, message: "任务ID不能为空", trigger: "blur" }
        ],
        overview: [
          { required: true, message: "巡航概述不能为空", trigger: "blur" }
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
    /** 查询巡航结果列表 */
    getList() {
      this.loading = true
      listResult(this.queryParams).then(response => {
        this.resultList = response.rows
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
        resultId: null,
        resultCode: null,
        taskId: null,
        overview: null,
        findings: null,
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
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.resultId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加巡航结果"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const resultId = row.resultId || this.ids
      getResult(resultId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航结果"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.resultId != null) {
            updateResult(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addResult(this.form).then(response => {
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
      const resultIds = row.resultId || this.ids
      this.$modal.confirm('是否确认删除巡航结果编号为"' + resultIds + '"的数据项？').then(function() {
        return delResult(resultIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('uav/result/export', {
        ...this.queryParams
      }, `result_${new Date().getTime()}.xlsx`)
    },
    /** 1. 点击“查看轨迹”按钮触发 */
    async handleViewMap(row) {
      if (!row.taskId) {
        this.$modal.msgWarning("该结果记录未关联有效任务！");
        return;
      }

      this.currentResultCode = row.resultCode; // 弹窗显示的标题信息

      try {
        // 第一层：根据任务ID获取任务详情
        const taskResponse = await getTask(row.taskId);
        const routeId = taskResponse.data.routeId;

        if (!routeId) {
          this.$modal.msgWarning("该任务未绑定巡航航线！");
          return;
        }

        // 第二层：根据航线ID获取坐标数据
        const routeResponse = await getRoute(routeId);
        const routeData = routeResponse.data;

        if (!routeData.routePoints) {
          this.$modal.msgWarning("该航线暂无坐标点位数据！");
          return;
        }

        // 赋值坐标并打开弹窗
        this.currentRoutePoints = routeData.routePoints;
        this.mapOpen = true;

      } catch (error) {
        console.error("获取轨迹数据失败:", error);
        this.$modal.msgError("获取航线数据失败，请检查配置");
      }
    },

    /** 2. 初始化回显地图（逻辑基本与Task页一致，注意容器ID） */
    initEchoMap() {
      if (this.echoMap) {
        this.drawEchoRoute();
        return;
      }

      AMapLoader.load({
        key: "3e12b539ccc9cec93cc71e8ce8a65306",
        version: "2.0",
        plugins: ['AMap.Polyline', 'AMap.Marker']
      }).then((AMap) => {
        // 初始化地图
        this.echoMap = new AMap.Map("map-echo-container", {
          zoom: 14,
          center: [116.397428, 39.90923]
        });

        this.drawEchoRoute();
      }).catch(e => {
        console.error("地图加载失败:", e);
      });
    },

    /** 3. 核心画线逻辑：解析 JSON 并渲染折线与带序号的钉子 */
    drawEchoRoute() {
      if (!this.echoMap || !this.currentRoutePoints) return;

      // 清空画布
      this.echoMap.clearMap();

      try {
        const path = JSON.parse(this.currentRoutePoints);

        if (path && path.length > 0) {
          // ================= 1. 画折线 =================
          const polyline = new window.AMap.Polyline({
            path: path,
            strokeColor: "#FF33FF",
            strokeWeight: 6,
            strokeOpacity: 0.8,
            lineJoin: 'round',
            showDir: true
          });
          this.echoMap.add(polyline);

          // ================= 2. 画带序号的钉子 =================
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

          // 自动缩放视野
          this.echoMap.setFitView();
        }
      } catch (e) {
        console.error("航线解析失败:", e);
        this.$modal.msgError("航线轨迹渲染异常");
      }
    }
  }
}
</script>
