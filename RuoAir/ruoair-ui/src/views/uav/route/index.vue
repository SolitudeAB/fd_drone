<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="航线名称" prop="routeName">
        <el-input v-model="queryParams.routeName" placeholder="请输入航线名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['uav:route:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['uav:route:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['uav:route:remove']">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="el-icon-download" size="mini" @click="handleExport" v-hasPermi="['uav:route:export']">导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="routeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="航线ID" align="center" prop="routeId" width="90" />
      <el-table-column label="航线名称" align="center" prop="routeName" min-width="150" />
      <el-table-column label="预计时长(分钟)" align="center" prop="estimatedTime" width="130" />
      <el-table-column label="飞行高度(米)" align="center" prop="flightAltitude" width="120" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="240">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handleDetail(scope.row)">详情</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['uav:route:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['uav:route:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total>0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="1100px" append-to-body @opened="initMap">
      <el-row :gutter="20">
        <el-col :span="15">
          <div class="map-toolbar">
            <el-autocomplete
              v-model="searchKey"
              :fetch-suggestions="querySearch"
              placeholder="搜索地点并定位"
              @select="handleSearchSelect"
              size="mini"
              style="width: 250px;"
              clearable
            />
            <el-button type="primary" icon="el-icon-edit" size="mini" @click="startDraw">开始绘制</el-button>
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="clearDraw">清除重画</el-button>
          </div>
          <div id="map-container" class="map-container"></div>
        </el-col>

        <el-col :span="9">
          <el-form ref="form" :model="form" :rules="rules" label-width="90px">
            <el-form-item label="航线名称" prop="routeName">
              <el-input v-model="form.routeName" placeholder="请输入航线名称" />
            </el-form-item>
            <el-form-item label="预计时长" prop="estimatedTime">
              <el-input-number v-model="form.estimatedTime" :min="1" :precision="0" style="width: 100%;" />
            </el-form-item>
            <el-form-item label="飞行高度" prop="flightAltitude">
              <el-input-number v-model="form.flightAltitude" :min="10" style="width: 100%;" />
            </el-form-item>
            <el-form-item label="航线数据" prop="routePoints">
              <el-input v-model="form.routePoints" type="textarea" :rows="6" placeholder="在地图绘制后自动生成坐标数据" readonly />
            </el-form-item>
            <el-form-item label="备注" prop="remark">
              <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入内容" />
            </el-form-item>
          </el-form>
        </el-col>
      </el-row>

      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="航线详情" :visible.sync="detailOpen" width="900px" append-to-body @opened="initDetailMap">
      <el-descriptions :column="2" border size="small" v-if="detailForm.routeId">
        <el-descriptions-item label="航线ID">{{ detailForm.routeId }}</el-descriptions-item>
        <el-descriptions-item label="航线名称">{{ detailForm.routeName }}</el-descriptions-item>
        <el-descriptions-item label="预计时长">{{ detailForm.estimatedTime }} 分钟</el-descriptions-item>
        <el-descriptions-item label="飞行高度">{{ detailForm.flightAltitude }} 米</el-descriptions-item>
        <el-descriptions-item label="备注" :span="2">{{ detailForm.remark || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div id="map-detail-container" class="map-container" style="height: 300px; margin-top: 12px;"></div>
      <div class="detail-title">关联历史任务</div>
      <el-table :data="detailForm.relatedTasks || []" size="mini" border>
        <el-table-column label="任务名称" prop="taskName" min-width="160" />
        <el-table-column label="执行人" prop="executor" width="100" />
        <el-table-column label="设备名称" prop="equipmentName" min-width="120" />
        <el-table-column label="状态" width="100">
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
import { listRoute, getRoute, delRoute, addRoute, updateRoute } from "@/api/uav/route"
import AMapLoader from '@amap/amap-jsapi-loader'

const AMAP_KEY = process.env.VUE_APP_AMAP_KEY || "3e12b539ccc9cec93cc71e8ce8a65306"

export default {
  name: "Route",
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      routeList: [],
      title: "",
      open: false,
      detailOpen: false,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        routeName: null,
      },
      form: {},
      detailForm: {},
      rules: {
        routeName: [{ required: true, message: "航线名称不能为空", trigger: "blur" }],
      },
      map: null,
      mouseTool: null,
      detailMap: null,
      searchKey: '',
      autoComplete: null,
      searchMarker: null,
      routeMarkers: [],
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
      listRoute(this.queryParams).then(response => {
        this.routeList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    cancel() {
      this.open = false
      this.reset()
      if (this.mouseTool) {
        this.mouseTool.close(true)
      }
    },
    reset() {
      this.form = {
        routeId: null,
        routeName: null,
        estimatedTime: null,
        flightAltitude: null,
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
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.routeId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加巡航航线"
      if (this.map) this.map.clearMap()
    },
    handleUpdate(row) {
      this.reset()
      const routeId = row.routeId || this.ids[0]
      getRoute(routeId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航航线"
      })
    },
    handleDetail(row) {
      getRoute(row.routeId).then(response => {
        this.detailForm = response.data || {}
        this.detailOpen = true
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const action = this.form.routeId != null ? updateRoute : addRoute
        action(this.form).then(() => {
          this.$modal.msgSuccess(this.form.routeId != null ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const routeIds = row.routeId || this.ids
      this.$modal.confirm('是否确认删除巡航航线编号为"' + routeIds + '"的数据项？').then(() => {
        return delRoute(routeIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    handleExport() {
      this.download('uav/route/export', { ...this.queryParams }, `route_${new Date().getTime()}.xlsx`)
    },
    initMap() {
      if (this.map) {
        this.echoRoute(this.form.routePoints, this.map)
        return
      }
      AMapLoader.load({
        key: AMAP_KEY,
        version: "2.0",
        plugins: ['AMap.MouseTool', 'AMap.Polyline', 'AMap.Geolocation', 'AMap.AutoComplete']
      }).then((AMap) => {
        this.map = new AMap.Map("map-container", { zoom: 14, center: [119.192088, 26.050807] })
        this.autoComplete = new AMap.AutoComplete({ city: '全国' })
        this.mouseTool = new AMap.MouseTool(this.map)
        this.mouseTool.on('draw', (event) => {
          const pathData = event.obj.getPath()
          const pointsArray = pathData.map(p => [p.lng, p.lat])
          this.form.routePoints = JSON.stringify(pointsArray)
          this.addRouteMarkers(pointsArray, this.map)
          this.mouseTool.close(false)
        })
        this.echoRoute(this.form.routePoints, this.map)
      }).catch(() => {
        this.$modal.msgError("地图加载失败，请检查配置")
      })
    },
    initDetailMap() {
      if (!this.detailForm.routePoints) return
      AMapLoader.load({
        key: AMAP_KEY,
        version: "2.0",
        plugins: ['AMap.Polyline', 'AMap.Marker']
      }).then((AMap) => {
        if (!this.detailMap) {
          this.detailMap = new AMap.Map("map-detail-container", { zoom: 14, center: [119.192088, 26.050807] })
        } else {
          this.detailMap.clearMap()
        }
        this.echoRoute(this.detailForm.routePoints, this.detailMap)
      })
    },
    startDraw() {
      if (!this.mouseTool) return
      this.clearDraw()
      this.mouseTool.polyline({
        strokeColor: "#409EFF",
        strokeWeight: 5,
        strokeOpacity: 0.9,
        lineJoin: 'round'
      })
    },
    clearDraw() {
      if (this.map) this.map.clearMap()
      if (this.mouseTool) this.mouseTool.close(true)
      this.routeMarkers = []
      this.searchKey = ''
      this.form.routePoints = null
    },
    echoRoute(routePoints, targetMap) {
      if (!routePoints || !targetMap) return
      targetMap.clearMap()
      try {
        const path = JSON.parse(routePoints)
        if (!Array.isArray(path) || path.length === 0) return
        const polyline = new window.AMap.Polyline({
          path,
          strokeColor: "#67C23A",
          strokeWeight: 5,
          lineJoin: 'round'
        })
        targetMap.add(polyline)
        this.addRouteMarkers(path, targetMap)
        targetMap.setFitView()
      } catch (e) {
        this.$modal.msgError("航线数据格式异常")
      }
    },
    querySearch(queryString, cb) {
      if (!queryString || !this.autoComplete) {
        cb([])
        return
      }
      this.autoComplete.search(queryString, (status, result) => {
        if (status === 'complete' && result.tips) {
          const suggestions = result.tips.filter(item => item.location).map(item => ({
            value: item.name + (item.district ? ` (${item.district})` : ''),
            location: item.location
          }))
          cb(suggestions)
        } else {
          cb([])
        }
      })
    },
    handleSearchSelect(item) {
      if (!item.location || !this.map) return
      this.map.setCenter(item.location)
      this.map.setZoom(16)
      if (this.searchMarker) {
        this.map.remove(this.searchMarker)
      }
      this.searchMarker = new window.AMap.Marker({
        position: item.location,
        map: this.map,
        title: item.value
      })
    },
    addRouteMarkers(pointsArray, targetMap) {
      if (!targetMap) return
      pointsArray.forEach((pos, index) => {
        const marker = new window.AMap.Marker({
          position: pos,
          map: targetMap,
          anchor: 'bottom-center',
          label: {
            content: `<div style="padding: 0 4px; color: #409EFF; font-weight: bold;">${index + 1}</div>`,
            direction: 'right'
          }
        })
        this.routeMarkers.push(marker)
      })
    }
  }
}
</script>

<style scoped>
.map-toolbar {
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.map-container {
  width: 100%;
  height: 500px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
}

.detail-title {
  margin: 16px 0 8px;
  font-weight: 600;
}
</style>
