<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="82px">
      <el-form-item label="设备编号" prop="equipmentCode">
        <el-input v-model="queryParams.equipmentCode" placeholder="请输入设备编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="设备名称" prop="equipmentName">
        <el-input v-model="queryParams.equipmentName" placeholder="请输入设备名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="归属人" prop="owner">
        <el-input v-model="queryParams.owner" placeholder="请输入归属人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="设备状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择设备状态" clearable>
          <el-option v-for="dict in dict.type.sys_uav_status" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['uav:equipment:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['uav:equipment:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['uav:equipment:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['uav:equipment:export']">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="equipmentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="设备编号" align="center" prop="equipmentCode" width="120" />
      <el-table-column label="设备名称" align="center" prop="equipmentName" />
      <el-table-column label="设备型号" align="center" prop="equipmentModel" />
      <el-table-column label="续航(分钟)" align="center" prop="flightDuration" width="100" />
      <el-table-column label="摄像头参数" align="center" prop="cameraParams" show-overflow-tooltip />
      <el-table-column label="归属人" align="center" prop="owner" width="100" />
      <el-table-column label="设备状态" align="center" prop="status" width="100">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_uav_status" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="230">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleDetail(scope.row)">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['uav:equipment:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['uav:equipment:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="560px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="设备编号" prop="equipmentCode">
          <el-input v-model="form.equipmentCode" placeholder="请输入设备编号" :disabled="form.equipmentId != null" />
        </el-form-item>
        <el-form-item label="设备名称" prop="equipmentName">
          <el-input v-model="form.equipmentName" placeholder="请输入设备名称" />
        </el-form-item>
        <el-form-item label="设备型号" prop="equipmentModel">
          <el-input v-model="form.equipmentModel" placeholder="请输入设备型号" />
        </el-form-item>
        <el-form-item label="续航时长" prop="flightDuration">
          <el-input-number v-model="form.flightDuration" :min="1" :precision="0" style="width: 100%;" />
        </el-form-item>
        <el-form-item label="摄像头参数" prop="cameraParams">
          <el-input v-model="form.cameraParams" placeholder="请输入摄像头参数" />
        </el-form-item>
        <el-form-item label="归属人" prop="owner">
          <el-input v-model="form.owner" placeholder="请输入归属人" />
        </el-form-item>
        <el-form-item label="设备状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择设备状态" style="width: 100%;">
            <el-option v-for="dict in dict.type.sys_uav_status" :key="dict.value" :label="dict.label" :value="dict.value" />
          </el-select>
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

    <el-dialog title="设备详情" :visible.sync="detailOpen" width="900px" append-to-body>
      <el-descriptions :column="2" border size="small" v-if="detailForm.equipmentId">
        <el-descriptions-item label="设备编号">{{ detailForm.equipmentCode }}</el-descriptions-item>
        <el-descriptions-item label="设备名称">{{ detailForm.equipmentName }}</el-descriptions-item>
        <el-descriptions-item label="设备型号">{{ detailForm.equipmentModel }}</el-descriptions-item>
        <el-descriptions-item label="续航时长">{{ detailForm.flightDuration }} 分钟</el-descriptions-item>
        <el-descriptions-item label="摄像头参数">{{ detailForm.cameraParams || '-' }}</el-descriptions-item>
        <el-descriptions-item label="归属人">{{ detailForm.owner || '-' }}</el-descriptions-item>
        <el-descriptions-item label="设备状态">
          <dict-tag :options="dict.type.sys_uav_status" :value="detailForm.status" />
        </el-descriptions-item>
        <el-descriptions-item label="备注">{{ detailForm.remark || '-' }}</el-descriptions-item>
      </el-descriptions>

      <div class="detail-title">关联历史任务</div>
      <div v-if="detailForm.pendingTaskCount !== undefined || detailForm.activeTaskCount !== undefined" style="margin-bottom: 8px; font-size: 13px; color: #606266;">
        <el-tag size="small" type="info" style="margin-right: 8px;">待执行: {{ detailForm.pendingTaskCount || 0 }}</el-tag>
        <el-tag size="small" style="margin-right: 8px;">执行中: {{ detailForm.activeTaskCount || 0 }}</el-tag>
      </div>
      <el-table :data="detailForm.relatedTasks || []" size="mini" border>
        <el-table-column label="任务名称" prop="taskName" min-width="160" />
        <el-table-column label="执行人" prop="executor" width="100" />
        <el-table-column label="航线名称" prop="routeName" min-width="120" />
        <el-table-column label="任务状态" width="100">
          <template slot-scope="scope">
            <dict-tag :options="taskStatusOptions" :value="scope.row.taskStatus" />
          </template>
        </el-table-column>
        <el-table-column label="开始时间" width="160">
          <template slot-scope="scope">{{ parseTime(scope.row.startTime) }}</template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { listEquipment, getEquipment, delEquipment, addEquipment, updateEquipment } from "@/api/uav/equipment"

export default {
  name: "Equipment",
  dicts: ['sys_uav_status', 'sys_uav_task_status'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      equipmentList: [],
      title: "",
      open: false,
      detailOpen: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        equipmentCode: null,
        equipmentName: null,
        owner: null,
        status: null,
      },
      form: {},
      detailForm: {},
      rules: {
        equipmentCode: [{ required: true, message: "设备编号不能为空", trigger: "blur" }],
        equipmentName: [{ required: true, message: "设备名称不能为空", trigger: "blur" }],
        status: [{ required: true, message: "设备状态不能为空", trigger: "change" }]
      },
      taskStatusOptions: [
        { label: "待执行", value: "0" },
        { label: "执行中", value: "1" },
        { label: "已完成", value: "2" },
        { label: "已取消", value: "3" }
      ]
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listEquipment(this.queryParams).then(response => {
        this.equipmentList = response.rows
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
        equipmentId: null,
        equipmentCode: null,
        equipmentName: null,
        equipmentModel: null,
        flightDuration: null,
        cameraParams: null,
        owner: null,
        status: "0",
        remark: null
      }
      this.resetForm("form")
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.equipmentId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加无人机设备"
    },
    handleUpdate(row) {
      this.reset()
      const equipmentId = row.equipmentId || this.ids[0]
      getEquipment(equipmentId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改无人机设备"
      })
    },
    handleDetail(row) {
      getEquipment(row.equipmentId).then(response => {
        this.detailForm = response.data || {}
        this.detailOpen = true
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const action = this.form.equipmentId != null ? updateEquipment : addEquipment
        action(this.form).then(() => {
          this.$modal.msgSuccess(this.form.equipmentId != null ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const equipmentIds = row.equipmentId || this.ids
      this.$modal.confirm('是否确认删除无人机设备编号为"' + equipmentIds + '"的数据项？').then(() => {
        return delEquipment(equipmentIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('uav/equipment/export', { ...this.queryParams }, `equipment_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>

<style scoped>
.detail-title {
  margin: 16px 0 8px;
  font-weight: 600;
}
</style>
