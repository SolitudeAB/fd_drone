<template>
  <div class="app-container home-dashboard">
    <el-row :gutter="20" class="panel-group">
      <el-col :span="6" class="card-panel-col">
        <el-card shadow="hover" class="data-card">
          <div class="card-header">无人机设备总数</div>
          <div class="card-num color-blue">{{ dashData.equipmentTotal }}</div>
        </el-card>
      </el-col>
      <el-col :span="6" class="card-panel-col">
        <el-card shadow="hover" class="data-card">
          <div class="card-header">航线规划总数</div>
          <div class="card-num color-green">{{ dashData.routeTotal }}</div>
        </el-card>
      </el-col>
      <el-col :span="6" class="card-panel-col">
        <el-card shadow="hover" class="data-card">
          <div class="card-header">累计任务总数</div>
          <div class="card-num color-orange">{{ dashData.taskTotal }}</div>
        </el-card>
      </el-col>
      <el-col :span="6" class="card-panel-col">
        <el-card shadow="hover" class="data-card">
          <div class="card-header">归档结果总数</div>
          <div class="card-num color-purple">{{ dashData.resultTotal }}</div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="chart-group">
      <el-col :span="10">
        <el-card shadow="hover">
          <div slot="header" class="clearfix">
            <span>设备运行状态分布</span>
          </div>
          <div ref="pieChart" style="height: 350px"></div>
        </el-card>
      </el-col>

      <el-col :span="14">
        <el-card shadow="hover">
          <div slot="header" class="clearfix">
            <span>近七天巡航任务趋势</span>
          </div>
          <div ref="lineChart" style="height: 350px"></div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
// 引入 ECharts
import * as echarts from 'echarts'
import { getStats } from "@/api/dashboard";

export default {
  name: "Index",
  data() {
    return {
      // 1. 这里是模拟的后台数据，后续替换为调用接口获取
      dashData: {
        equipmentTotal: 15,
        routeTotal: 24,
        taskTotal: 86,
        resultTotal: 79
      },
      // 图表实例对象
      pieChartInstance: null,
      lineChartInstance: null
    };
  },
  mounted() {
    // 页面挂载完成后，初始化图表
    this.$nextTick(() => {
      this.getData();
      // 监听浏览器窗口大小变化，让图表自适应缩放
      window.addEventListener("resize", this.resizeCharts);
    });
  },
  beforeDestroy() {
    // 组件销毁前，清理事件监听和图表实例，防止内存泄漏
    window.removeEventListener("resize", this.resizeCharts);
    if (this.pieChartInstance) this.pieChartInstance.dispose();
    if (this.lineChartInstance) this.lineChartInstance.dispose();
  },
  methods: {
    getData() {
      getStats().then(response => {
        // 1. 替换四大金刚数字
        this.dashData.equipmentTotal = response.data.equipmentTotal;
        this.dashData.routeTotal = response.data.routeTotal;
        this.dashData.taskTotal = response.data.taskTotal;
        this.dashData.resultTotal = response.data.resultTotal;

        // 2. 将后端返回的饼图数据喂给 ECharts
        // (注意：这里需要把后端的 status 字典值翻译成中文，可以在 SQL 里写 CASE WHEN，或者在前端翻译)
        const pieData = response.data.pieData;

        // 3. 将后端返回的折线图数据解构出 X轴 和 Y轴
        const lineX = response.data.lineData.map(item => item.dateStr);
        const lineY = response.data.lineData.map(item => item.taskCount);

        // 4. 数据准备好后，初始化图表
        this.initPieChart(pieData);
        this.initLineChart(lineX, lineY);
      });
    },
    /** 初始化饼图：设备状态 */
    initPieChart(pieData) {
      this.pieChartInstance = echarts.init(this.$refs.pieChart);
      const option = {
        tooltip: { trigger: 'item' },
        legend: { top: 'bottom' },
        color: ['#67C23A', '#E6A23C', '#F56C6C', '#909399'],
        series: [
          {
            name: '设备状态',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            itemStyle: {
              borderRadius: 10,
              borderColor: '#fff',
              borderWidth: 2
            },
            label: { show: false, position: 'center' },
            emphasis: {
              label: { show: true, fontSize: 20, fontWeight: 'bold' }
            },
            labelLine: { show: false },
            // 【关键修复】使用后端传来的数据，如果没有数据则显示占位
            data: pieData && pieData.length > 0 ? pieData : [{ value: 0, name: '暂无数据' }]
          }
        ]
      };
      this.pieChartInstance.setOption(option);
    },

    /** 初始化折线图：任务趋势 */
    initLineChart(xData, yData) {
      this.lineChartInstance = echarts.init(this.$refs.lineChart);
      const option = {
        tooltip: {
          trigger: 'axis',
          axisPointer: { type: 'cross' }
        },
        grid: { left: '3%', right: '4%', bottom: '3%', containLabel: true },
        xAxis: {
          type: 'category',
          boundaryGap: false,
          // 【关键修复】使用后端传来的 X 轴数据
          data: xData && xData.length > 0 ? xData : ['暂无数据']
        },
        yAxis: { type: 'value' },
        series: [
          {
            name: '执行任务数',
            type: 'line',
            smooth: true,
            lineStyle: { width: 3, color: '#409EFF' },
            itemStyle: { color: '#409EFF' },
            areaStyle: {
              color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                { offset: 0, color: 'rgba(64,158,255,0.3)' },
                { offset: 1, color: 'rgba(64,158,255,0)' }
              ])
            },
            // 【关键修复】使用后端传来的 Y 轴数据
            data: yData && yData.length > 0 ? yData : [0]
          }
        ]
      };
      this.lineChartInstance.setOption(option);
    },

    /** 窗口缩放自适应 */
    resizeCharts() {
      if (this.pieChartInstance) this.pieChartInstance.resize();
      if (this.lineChartInstance) this.lineChartInstance.resize();
    }
  }
};
</script>

<style scoped>
.home-dashboard {
  padding: 20px;
  background-color: #f0f2f5;
  min-height: calc(100vh - 84px);
}
.panel-group {
  margin-bottom: 20px;
}
.data-card {
  text-align: center;
  border-radius: 8px;
  border: none;
}
.card-header {
  font-size: 16px;
  color: #606266;
  font-weight: bold;
  margin-bottom: 10px;
}
.card-num {
  font-size: 36px;
  font-weight: bold;
  margin-top: 10px;
}
/* 定义四种卡片数字的颜色 */
.color-blue { color: #409EFF; }
.color-green { color: #67C23A; }
.color-orange { color: #E6A23C; }
.color-purple { color: #9c27b0; }

.chart-group .el-card {
  border-radius: 8px;
  border: none;
}
</style>
