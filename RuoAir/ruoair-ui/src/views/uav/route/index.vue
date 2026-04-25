<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="航线名称" prop="routeName">
        <el-input
          v-model="queryParams.routeName"
          placeholder="请输入航线名称"
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
          v-hasPermi="['uav:route:add']"
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
          v-hasPermi="['uav:route:edit']"
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
          v-hasPermi="['uav:route:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['uav:route:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="routeList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="航线ID" align="center" prop="routeId" />
      <el-table-column label="航线名称" align="center" prop="routeName" />
      <el-table-column label="预计时长" align="center" prop="estimatedTime" />
      <el-table-column label="飞行高度" align="center" prop="flightAltitude" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['uav:route:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['uav:route:remove']"
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

    <!-- 添加或修改巡航航线对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="1100px" append-to-body @opened="initMap">
      <el-row :gutter="20">
        <el-col :span="15">
          <div style="margin-bottom: 10px; display: flex; align-items: center; gap: 10px;">
            <el-autocomplete
              v-model="searchKey"
              :fetch-suggestions="querySearch"
              placeholder="搜索地点并定位"
              @select="handleSearchSelect"
              size="mini"
              style="width: 250px;"
              clearable
            ></el-autocomplete>

            <el-button type="primary" icon="el-icon-edit" size="mini" @click="startDraw">开始绘制</el-button>
            <el-button type="danger" icon="el-icon-delete" size="mini" @click="clearDraw">清除重画</el-button>
            <span style="font-size: 12px; color: #909399; margin-left: 10px;">
              操作提示：点击地图打点，双击左键或单击右键结束绘制。
            </span>
          </div>
          <div id="map-container" style="width: 100%; height: 500px; border: 1px solid #DCDFE6; border-radius: 4px;"></div>
        </el-col>

        <el-col :span="9">
          <el-form ref="form" :model="form" :rules="rules" label-width="90px">
            <el-form-item label="航线名称" prop="routeName">
              <el-input v-model="form.routeName" placeholder="请输入航线名称" />
            </el-form-item>

            <el-row>
              <el-col :span="24">
                <el-form-item label="预计时长" prop="estimatedTime">
                  <el-input-number v-model="form.estimatedTime" :min="1" placeholder="分钟" style="width: 100%;" />
                </el-form-item>
              </el-col>
              <el-col :span="24">
                <el-form-item label="飞行高度" prop="flightAltitude">
                  <el-input-number v-model="form.flightAltitude" :min="10" placeholder="米" style="width: 100%;" />
                </el-form-item>
              </el-col>
            </el-row>

            <el-form-item label="航线数据" prop="routePoints">
              <el-input
                v-model="form.routePoints"
                type="textarea"
                :rows="6"
                placeholder="在地图绘制后自动生成坐标数据"
                readonly
              />
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
  </div>
</template>

<script>
import { listRoute, getRoute, delRoute, addRoute, updateRoute } from "@/api/uav/route"
import AMapLoader from '@amap/amap-jsapi-loader'; // 【新增】引入高德地图 Loader

export default {
  name: "Route",
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
      // 巡航航线表格数据
      routeList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        routeName: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        routeName: [
          { required: true, message: "航线名称不能为空", trigger: "blur" }
        ],
      },

      // 地图相关实例
      map: null,
      mouseTool: null,

      // 搜索与定位相关变量
      searchKey: '',      // 搜索关键字
      autoComplete: null, // 高德搜索联想实例
      searchMarker: null, // 搜索结果在地图上显示的钉子图标

      // 用来存放航线所有拐点钉子的数组
      routeMarkers: [],
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询巡航航线列表 */
    getList() {
      this.loading = true
      listRoute(this.queryParams).then(response => {
        this.routeList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
      // 【新增】取消时关闭绘制工具
      if(this.mouseTool) {
        this.mouseTool.close(true);
      }
    },
    // 表单重置
    reset() {
      this.form = {
        routeId: null,
        routeName: null,
        estimatedTime: null,
        flightAltitude: null,
        routePoints: null,
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
      this.ids = selection.map(item => item.routeId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加巡航航线"
      // 【新增】每次点击新增，如果有地图，强制清空画布
      if(this.map) {
        this.map.clearMap();
      }
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const routeId = row.routeId || this.ids
      getRoute(routeId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改巡航航线"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.routeId != null) {
            updateRoute(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addRoute(this.form).then(response => {
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
      const routeIds = row.routeId || this.ids
      this.$modal.confirm('是否确认删除巡航航线编号为"' + routeIds + '"的数据项？').then(function() {
        return delRoute(routeIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('uav/route/export', {
        ...this.queryParams
      }, `route_${new Date().getTime()}.xlsx`)
    },

    /**
     * 1. 弹窗打开后，初始化地图
     * (通过 @opened="initMap" 触发，确保 DOM 已经渲染完毕)
     */
    initMap() {
      // 如果地图已经实例化，直接回显数据，不再重复创建
      if (this.map) {
        this.echoRoute();
        return;
      }

      AMapLoader.load({
        key: "3e12b539ccc9cec93cc71e8ce8a65306", // 【关键】填入你的 API Key（不是安全密钥）
        version: "2.0",
        plugins: ['AMap.MouseTool', 'AMap.Polyline', 'AMap.Geolocation', 'AMap.AutoComplete'] // 引入鼠标工具和折线插件
      }).then((AMap) => {
        // 实例化地图
        this.map = new AMap.Map("map-container", {
          zoom: 14,
          center: [119.192088,26.050807] // 默认中心点（生活区的经纬度）
        });

        // ------------------ 自动定位逻辑 ------------------
        let geolocation = new AMap.Geolocation({
          enableHighAccuracy: true, // 是否使用高精度定位
          timeout: 10000,           // 超过10秒后停止定位
          zoomToAccuracy: true,     // 定位成功后调整地图视野范围
          position: 'RB'            // 定位按钮显示在右下角
        });
        this.map.addControl(geolocation);
        geolocation.getCurrentPosition((status, result) => {
          if(status === 'complete'){
            this.$modal.msgSuccess("当前位置定位成功");
          } else {
            // 浏览器可能会因为安全策略(如非HTTPS)拦截定位
            console.log("定位失败:", result);
          }
        });

        // ------------------ 初始化搜索联想服务 ------------------
        this.autoComplete = new AMap.AutoComplete({ city: '全国' });

        // 实例化鼠标绘制工具
        this.mouseTool = new AMap.MouseTool(this.map);

        // 监听绘制完成事件
        this.mouseTool.on('draw', (event) => {
          // 获取画出来的这根折线的所有坐标点
          let pathData = event.obj.getPath();
          // 提取出纯粹的经纬度数组: [[116.4, 39.9], [116.5, 39.8], ...]
          let pointsArray = pathData.map(p => [p.lng, p.lat]);

          // 转换成 JSON 字符串，塞进表单里准备提交给后端
          this.form.routePoints = JSON.stringify(pointsArray);

          // 绘制完折线后，立刻给所有的拐点打上钉子！
          this.addRouteMarkers(pointsArray);

          this.$modal.msgSuccess("航线绘制成功，数据已生成！");
          this.mouseTool.close(false); // 关闭绘制模式，保留刚才画的线 (参数 false 表示不清除)
        });

        // 如果是点击“修改”进来的，顺便回显之前的航线
        this.echoRoute();

      }).catch(e => {
        console.error("高德地图加载失败:", e);
        this.$modal.msgError("地图加载失败，请检查密钥配置！");
      });
    },

    /** 2. 点击“开始绘制”按钮 */
    startDraw() {
      if (!this.mouseTool) return;
      this.clearDraw(); // 画新线之前先清空旧线
      // 开启折线绘制模式，并设置航线的样式
      this.mouseTool.polyline({
        strokeColor: "#409EFF",  // 航线颜色（科技蓝）
        strokeWeight: 5,         // 线条宽度
        strokeOpacity: 0.9,      // 透明度
        borderWeight: 2,         // 边框宽度
        strokeColor: "#409EFF",
        lineJoin: 'round'
      });
      this.$modal.msg("请在地图上单击鼠标左键开始打点...");
    },

    /** 3. 点击“清除重画”按钮 */
    clearDraw() {
      if (this.map) {
        this.map.clearMap(); // 清空地图上所有的覆盖物（折线）
      }
      if (this.mouseTool) {
        this.mouseTool.close(true); // 关闭工具，并强制清除未画完的痕迹
      }
      if (this.searchMarker) {
        this.searchMarker = null;// 清理搜索关键词和钉子
      }

      this.routeMarkers = [];
      this.searchKey = '';
      this.form.routePoints = null; // 清空表单里的坐标数据
    },

    /** 4. 数据回显：将数据库里的 JSON 字符串重新画在地图上 */
    echoRoute() {
      // 必须有数据，且地图已经初始化
      if (this.form.routePoints && this.map) {
        this.map.clearMap(); // 先清空旧的
        try {
          let path = JSON.parse(this.form.routePoints);
          if (path && path.length > 0) {
            // 创建折线对象
            let polyline = new AMap.Polyline({
              path: path,
              strokeColor: "#67C23A", // 回显时的颜色（成功绿）
              strokeWeight: 5,
              lineJoin: 'round'
            });
            this.map.add(polyline); // 加载到地图上
            this.addRouteMarkers(path); // 数据回显时，也把这些钉子画出来
            this.map.setFitView();  // 自动缩放平移地图，把完整的航线包围进视野内！(极度好用)
          }
        } catch(e) {
          console.error("解析航线坐标数据失败", e);
        }
      }
    },
    /** 处理搜索联想建议 */
    querySearch(queryString, cb) {
      if (!queryString) {
        cb([]);
        return;
      }
      this.autoComplete.search(queryString, (status, result) => {
        if (status === 'complete' && result.tips) {
          // 提取带有经纬度的数据，并组装成 el-autocomplete 需要的 {value: 'xxx'} 格式
          const suggestions = result.tips
            .filter(item => item.location)
            .map(item => ({
              value: item.name + (item.district ? ` (${item.district})` : ''),
              location: item.location
            }));
          cb(suggestions);
        } else {
          cb([]);
        }
      });
    },

    /** 选择搜索结果后，在地图打下钉子并跳转 */
    handleSearchSelect(item) {
      if (!item.location) return;

      // 1. 将地图中心移动到搜索到的地点，并放大层级
      this.map.setCenter(item.location);
      this.map.setZoom(16);

      // 2. 如果之前已经有搜索的钉子了，先移除掉
      if (this.searchMarker) {
        this.map.remove(this.searchMarker);
      }

      // 3. 在选择的位置打上新钉子图标
      this.searchMarker = new window.AMap.Marker({
        position: item.location,
        map: this.map,
        title: item.value,
        animation: 'AMAP_ANIMATION_DROP' // 给钉子加一个掉落动画（可选）
      });
    },

    /** 为航线的每个拐点生成钉子图标 */
    addRouteMarkers(pointsArray) {
      // 1. 如果地图上已经有之前的拐点钉子，先清理掉，防止重复叠加
      if (this.routeMarkers.length > 0) {
        this.map.remove(this.routeMarkers);
        this.routeMarkers = [];
      }

      // 2. 遍历你画出的每一个点位
      pointsArray.forEach((pos, index) => {
        let marker = new window.AMap.Marker({
          position: pos,
          map: this.map,
          anchor: 'bottom-center', // 图标锚点位置
          // 你甚至可以给钉子加上序号，让答辩效果更拉风 (可选)
          label: {
            content: `<div style="padding: 0 4px; color: #409EFF; font-weight: bold;">${index + 1}</div>`,
            direction: 'right'
          }
        });
        this.routeMarkers.push(marker);
      });
    },
  }
}
</script>
