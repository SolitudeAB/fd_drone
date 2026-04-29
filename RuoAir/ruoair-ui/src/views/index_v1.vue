<template>
  <div class="dashboard-editor-container">
    <panel-group :stats="stats" />

    <el-row :gutter="20" style="margin-bottom: 32px;">
      <el-col :xs="24" :sm="12" :lg="6">
        <div class="stat-card">
          <div class="stat-label">今日待执行任务</div>
          <div class="stat-value pending">{{ stats.pendingToday || 0 }}</div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="6">
        <div class="stat-card">
          <div class="stat-label">本周完成任务</div>
          <div class="stat-value completed">{{ stats.completedThisWeek || 0 }}</div>
        </div>
      </el-col>
    </el-row>

    <el-row style="background:#fff;padding:16px 16px 0;margin-bottom:32px;">
      <line-chart :line-data="lineData" />
    </el-row>

    <el-row :gutter="32">
      <el-col :xs="24" :sm="24" :lg="12">
        <div class="chart-wrapper">
          <pie-chart :pie-data="pieData" />
        </div>
      </el-col>
      <el-col :xs="24" :sm="24" :lg="12">
        <div class="chart-wrapper">
          <div class="quick-links">
            <div class="quick-title">快捷入口</div>
            <el-row :gutter="12">
              <el-col :span="6" v-for="link in quickLinks" :key="link.path">
                <div class="quick-card" @click="$router.push(link.path)">
                  <svg-icon :icon-class="link.icon" style="font-size: 28px; color: #409EFF;" />
                  <span>{{ link.label }}</span>
                </div>
              </el-col>
            </el-row>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import PanelGroup from './dashboard/PanelGroup'
import LineChart from './dashboard/LineChart'
import PieChart from './dashboard/PieChart'
import { getDashboardStats } from '@/api/uav/dashboard'

export default {
  name: 'Index',
  components: { PanelGroup, LineChart, PieChart },
  data() {
    return {
      stats: {},
      pieData: [],
      lineData: [],
      quickLinks: [
        { label: '设备管理', path: '/uav/equipment', icon: 'component' },
        { label: '航线规划', path: '/uav/route', icon: 'guide' },
        { label: '任务管理', path: '/uav/task', icon: 'job' },
        { label: '结果管理', path: '/uav/result', icon: 'form' }
      ]
    }
  },
  created() {
    this.fetchData()
  },
  methods: {
    fetchData() {
      getDashboardStats().then(res => {
        const data = res.data || {}
        this.stats = data
        this.pieData = data.pieData || []
        this.lineData = data.lineData || []
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);
  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
}
.stat-card {
  background: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 4px 4px 40px rgba(0,0,0,.05);
  text-align: center;
  .stat-label { font-size: 14px; color: #909399; margin-bottom: 8px; }
  .stat-value { font-size: 32px; font-weight: bold; }
  .stat-value.pending { color: #E6A23C; }
  .stat-value.completed { color: #67C23A; }
}
.quick-links {
  padding: 10px 0;
  .quick-title { font-size: 14px; font-weight: bold; color: #303133; margin-bottom: 16px; text-align: center; }
  .quick-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    padding: 16px 8px;
    cursor: pointer;
    border-radius: 6px;
    transition: all 0.3s;
    span { font-size: 12px; color: #606266; }
    &:hover { background: #f0f2f5; transform: translateY(-2px); }
  }
}
@media (max-width:1024px) {
  .chart-wrapper { padding: 8px; }
}
</style>
