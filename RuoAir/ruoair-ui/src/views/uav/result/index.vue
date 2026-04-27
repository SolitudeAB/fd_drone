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
      <el-table-column label="任务状态" align="center" prop="taskStatus" width="100">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.taskStatus === '0'" type="info">待执行</el-tag>
          <el-tag v-else-if="scope.row.taskStatus === '1'">执行中</el-tag>
          <el-tag v-else-if="scope.row.taskStatus === '2'" type="success">已完成</el-tag>
          <el-tag v-else-if="scope.row.taskStatus === '3'" type="danger">已取消</el-tag>
          <el-tag v-else type="info">{{ scope.row.taskStatus }}</el-tag>
        </template>
      </el-table-column>
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
          <el-button size="mini" type="text" icon="el-icon-download" @click="handleReport(scope.row)">PDF</el-button>
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
      <div v-if="detailForm.aiImageUrl" class="detail-title">AI识别</div>
      <div v-if="detailForm.aiImageUrl" style="margin-bottom: 12px;">
        <el-button type="primary" size="mini" icon="el-icon-cpu" @click="handleAiRecognize" :loading="aiRecognizing" :disabled="aiRecognized">
          {{ aiRecognized ? '已识别' : '开始AI识别' }}
        </el-button>
        <el-button v-if="aiRecognized" size="mini" icon="el-icon-refresh" @click="handleAiRecognize">重新识别</el-button>
        <span v-if="aiStatusHint" style="margin-left: 8px; color: #909399; font-size: 12px;">{{ aiStatusHint }}</span>
      </div>
      <div v-if="recognitionResult" style="background: #f8f9fa; padding: 12px; border-radius: 6px; margin-bottom: 12px;">
        <div style="font-weight: bold; margin-bottom: 6px; color: #303133;">识别结果（模型：{{ recognitionResult.model || '-' }}）</div>
        <div style="font-size: 13px; line-height: 1.8; white-space: pre-wrap; color: #606266; margin-bottom: 12px;">{{ recognitionResult.recognition }}</div>
      </div>
      <div v-if="detailForm.aiImageUrl" class="detail-title">图片</div>
      <div v-if="detailForm.aiImageUrl" style="max-width: 100%; position: relative; border: 1px solid #dcdfe6; border-radius: 6px; overflow: hidden; background: #000;">
        <el-image
          :src="detailForm.aiImageUrl"
          :preview-src-list="[detailForm.aiImageUrl]"
          fit="contain"
          style="width: 100%; display: block; cursor: pointer;"
          @load="onAiImageLoad"
          ref="aiImage"
        />
        <div
          v-for="(box, idx) in boundingBoxes"
          :key="idx"
          :style="box.style"
          class="ai-bounding-box"
          @click.stop
        >
          <span class="box-label">{{ box.name }}</span>
        </div>
      </div>
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
        <el-form-item label="AI识别图片" prop="aiImageUrl" class="ai-upload-area">
          <div
            class="drop-zone"
            :class="{ 'drop-active': dragOver }"
            @dragover.prevent="dragOver = true"
            @dragleave="dragOver = false"
            @drop.prevent="handleDrop"
          >
            <div v-if="!form.aiImageUrl" style="text-align: center; padding: 20px 0;">
              <i class="el-icon-upload2" style="font-size: 28px; color: #c0c4cc;"></i>
              <div style="color: #909399; margin-top: 8px; font-size: 13px;">
                拖放图片到此处 或 点击下方按钮上传<br>
                <span style="font-size: 11px; color: #c0c4cc;">支持 JPG / PNG / WEBP，≤5MB</span>
              </div>
            </div>
            <div v-else style="text-align: center;">
              <el-image :src="form.aiImageUrl" fit="contain" style="max-height: 180px; cursor: pointer;" :preview-src-list="[form.aiImageUrl]" />
              <div style="margin-top: 6px;">
                <el-tag size="mini" type="success" style="margin-right: 6px;">已上传</el-tag>
                <el-button size="mini" type="text" icon="el-icon-delete" @click="removeImage" style="color: #f56c6c;">移除</el-button>
              </div>
            </div>
          </div>
          <div style="margin-top: 8px; display: flex; gap: 8px; flex-wrap: wrap; align-items: center;">
            <el-upload
              action=""
              :http-request="handleImageUpload"
              :show-file-list="false"
              accept="image/png,image/jpeg,image/jpg,image/gif,image/webp"
              :before-upload="beforeImageUpload"
            >
              <el-button size="small" type="primary" plain icon="el-icon-upload">选择图片</el-button>
            </el-upload>
            <el-button v-if="form.aiImageUrl" size="small" type="success" icon="el-icon-cpu" @click="handleFormAiAnalyze" :loading="aiFormAnalyzing">
              自动分析填充
            </el-button>
            <el-input v-model="form.aiImageUrl" placeholder="或粘贴图片URL" size="small" style="flex: 1; min-width: 180px;" clearable />
          </div>
          <div v-if="aiFormStatusMsg" style="margin-top: 4px; font-size: 12px; color: #67C23A;">{{ aiFormStatusMsg }}</div>
          <div v-if="aiFormErrorMsg" style="margin-top: 4px; font-size: 12px; color: #F56C6C;">{{ aiFormErrorMsg }}</div>
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
import { listResult, getResult, delResult, addResult, updateResult, recognizeResult, checkAiStatus, exportReport, uploadResultImage, autoAnalyze } from "@/api/uav/result"
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
        overview: [{ required: true, message: "巡航概述不能为空", trigger: "blur" }],
        aiImageUrl: [{ required: true, message: "请上传/插入巡航结果图片后再进行保存", trigger: "change" }],
        completedTime: [{ required: true, message: "完成时间不能为空", trigger: "change" }]
      },
      mapOpen: false,
      echoMap: null,
      currentTaskName: '',
      currentRoutePoints: '',
      aiRecognizing: false,
      aiRecognized: false,
      recognitionResult: null,
      aiStatusHint: '',
      boundingBoxes: [],
      aiImageNaturalSize: { w: 0, h: 0 },
      dragOver: false,
      aiFormAnalyzing: false,
      aiFormStatusMsg: '',
      aiFormErrorMsg: ''
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
      this.form.completedTime = this.parseTime(new Date(), '{y}-{m}-{d} {h}:{i}:{s}')
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
        this.recognitionResult = null
        this.aiRecognized = false
        this.aiStatusHint = ''
        this.boundingBoxes = []
        this.detailOpen = true
        if (this.detailForm.aiImageUrl) {
          this.checkAiAvailability()
        }
      })
    },
    checkAiAvailability() {
      checkAiStatus().then(resp => {
        const data = resp.data || {}
        if (!data.available) {
          this.aiStatusHint = '提示：' + (data.message || 'AI接口不可用')
        }
      }).catch(() => {
        this.aiStatusHint = '提示：AI接口未连接或已失效'
      })
    },
    handleAiRecognize() {
      if (!this.detailForm.resultId) return
      this.aiRecognizing = true
      recognizeResult(this.detailForm.resultId).then(resp => {
        const data = resp.data || {}
        if (data.success) {
          this.recognitionResult = data
          this.aiRecognized = true
          this.aiStatusHint = ''
          this.buildBoundingBoxes(data.targets)
        } else {
          this.aiStatusHint = '识别失败：' + (data.message || '未知错误')
          this.$modal.msgWarning(data.message || 'AI识别失败')
        }
      }).catch(() => {
        this.aiStatusHint = '识别失败：API接口未连接或已失效'
        this.$modal.msgError('AI识别接口调用失败，请检查API配置')
      }).finally(() => {
        this.aiRecognizing = false
      })
    },
    handleReport(row) {
      if (row.resultId) {
        exportReport(row.resultId).then(response => {
          const blob = new Blob([response], { type: 'application/pdf' })
          const link = document.createElement('a')
          link.href = URL.createObjectURL(blob)
          link.download = '巡防报告_' + (row.resultCode || row.resultId) + '.pdf'
          link.click()
          URL.revokeObjectURL(link.href)
          this.$modal.msgSuccess("PDF报告下载成功")
        }).catch(() => {
          this.$modal.msgError("PDF报告导出失败")
        })
      }
    },
    onAiImageLoad() {
      if (this.recognitionResult && this.recognitionResult.targets) {
        this.buildBoundingBoxes(this.recognitionResult.targets)
      }
    },
    buildBoundingBoxes(targets) {
      if (!targets || targets.length === 0) {
        this.boundingBoxes = []
        return
      }
      const colors = ['#F56C6C', '#409EFF', '#67C23A', '#E6A23C', '#9B59B6', '#1ABC9C', '#E91E63', '#00BCD4']
      this.boundingBoxes = targets.map((t, idx) => ({
        name: t.name || t.description || '目标',
        style: {
          position: 'absolute',
          top: (t.top || '15') + '%',
          left: (t.left || '15') + '%',
          width: (t.width || '70') + '%',
          height: (t.height || '70') + '%',
          border: '2px solid ' + colors[idx % colors.length],
          backgroundColor: colors[idx % colors.length] + '25',
          borderRadius: '4px',
          display: 'flex',
          alignItems: 'flex-start',
          justifyContent: 'center',
          pointerEvents: 'none'
        }
      }))
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
    beforeImageUpload(file) {
      const isImage = file.type.startsWith('image/')
      if (!isImage) {
        this.$modal.msgError('只能上传图片文件！')
        return false
      }
      const isLt5M = file.size / 1024 / 1024 < 5
      if (!isLt5M) {
        this.$modal.msgError('图片大小不能超过 5MB！')
        return false
      }
      return true
    },
    handleImageUpload(params) {
      this.aiFormStatusMsg = ''
      this.aiFormErrorMsg = ''
      const formData = new FormData()
      formData.append('file', params.file)
      uploadResultImage(formData).then(resp => {
        this.form.aiImageUrl = resp.url || resp.fileName
        this.$modal.msgSuccess('图片上传成功')
        this.autoFillFromAi()
      }).catch(() => {
        this.$modal.msgError('图片上传失败')
      })
    },
    handleDrop(e) {
      this.dragOver = false
      const files = e.dataTransfer.files
      if (!files || files.length === 0) return
      const file = files[0]
      if (!this.beforeImageUpload(file)) return
      this.aiFormStatusMsg = ''
      this.aiFormErrorMsg = ''
      const formData = new FormData()
      formData.append('file', file)
      uploadResultImage(formData).then(resp => {
        this.form.aiImageUrl = resp.url || resp.fileName
        this.$modal.msgSuccess('图片上传成功')
        this.autoFillFromAi()
      }).catch(() => {
        this.$modal.msgError('图片上传失败')
      })
    },
    removeImage() {
      this.form.aiImageUrl = null
      this.aiFormStatusMsg = ''
      this.aiFormErrorMsg = ''
    },
    handleFormAiAnalyze() {
      this.autoFillFromAi()
    },
    autoFillFromAi() {
      if (!this.form.aiImageUrl) return
      this.aiFormAnalyzing = true
      this.aiFormStatusMsg = 'AI正在分析图片...'
      this.aiFormErrorMsg = ''
      const taskName = this.form.taskName || ''
      autoAnalyze(this.form.aiImageUrl, taskName).then(resp => {
        const { data } = resp
        if (data.success) {
          this.aiFormStatusMsg = 'AI分析完成！已自动填充发现情况、处理情况、备注，请核对后保存'
          if (data.findings) this.form.findings = data.findings
          if (data.handlingInfo) this.form.handlingInfo = data.handlingInfo
          if (data.remark) this.form.remark = data.remark
          if (!this.form.overview || this.form.overview === '本次巡防任务正常完成，无异常情况') {
            if (data.findings) this.form.overview = data.findings
          }
          if (data.targets && data.targets.length > 0) {
            this.aiFormStatusMsg += ' （检测到' + data.targets.length + '个目标）'
          }
        } else {
          this.aiFormErrorMsg = (data.message || 'AI分析失败').replace(/AI识别/g, 'AI分析')
        }
      }).catch(() => {
        this.aiFormErrorMsg = 'AI分析接口未连接或已失效，请手动填写各字段'
      }).finally(() => {
        this.aiFormAnalyzing = false
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
.ai-bounding-box {
  transition: all 0.2s;
}
.box-label {
  background: rgba(0,0,0,0.7);
  color: #fff;
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 3px;
  white-space: nowrap;
  position: absolute;
  top: -2px;
  left: 50%;
  transform: translate(-50%, -100%);
}
.drop-zone {
  border: 2px dashed #dcdfe6;
  border-radius: 8px;
  min-height: 100px;
  transition: all 0.3s;
  cursor: pointer;
}
.drop-zone.drop-active {
  border-color: #409EFF;
  background-color: rgba(64,158,255,0.05);
}
.ai-upload-area .el-form-item__content {
  display: block;
}
</style>
