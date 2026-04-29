<template>
  <el-row :gutter="40" class="panel-group">
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="goTo('/uav/equipment')">
        <div class="card-panel-icon-wrapper icon-equipment">
          <svg-icon icon-class="component" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">设备总数</div>
          <count-to :start-val="0" :end-val="stats.equipmentTotal || 0" :duration="2000" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="goTo('/uav/route')">
        <div class="card-panel-icon-wrapper icon-route">
          <svg-icon icon-class="guide" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">航线总数</div>
          <count-to :start-val="0" :end-val="stats.routeTotal || 0" :duration="2200" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="goTo('/uav/task')">
        <div class="card-panel-icon-wrapper icon-task">
          <svg-icon icon-class="job" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">任务总数</div>
          <count-to :start-val="0" :end-val="stats.taskTotal || 0" :duration="2400" class="card-panel-num" />
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" @click="goTo('/uav/result')">
        <div class="card-panel-icon-wrapper icon-result">
          <svg-icon icon-class="form" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">结果总数</div>
          <count-to :start-val="0" :end-val="stats.resultTotal || 0" :duration="2600" class="card-panel-num" />
        </div>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import CountTo from 'vue-count-to'

export default {
  components: { CountTo },
  props: {
    stats: {
      type: Object,
      default: () => ({ equipmentTotal: 0, routeTotal: 0, taskTotal: 0, resultTotal: 0 })
    }
  },
  methods: {
    goTo(path) {
      this.$router.push(path)
    }
  }
}
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 18px;
  .card-panel-col { margin-bottom: 32px; }
  .card-panel {
    height: 108px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
    border-radius: 4px;
    &:hover {
      .card-panel-icon-wrapper { color: #fff; }
      .icon-equipment { background: #40c9c6; }
      .icon-route { background: #36a3f7; }
      .icon-task { background: #f4516c; }
      .icon-result { background: #34bfa3; }
    }
    .icon-equipment { color: #40c9c6; }
    .icon-route { color: #36a3f7; }
    .icon-task { color: #f4516c; }
    .icon-result { color: #34bfa3; }
    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }
    .card-panel-icon { float: left; font-size: 48px; }
    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0;
      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }
      .card-panel-num { font-size: 20px; }
    }
  }
}
@media (max-width:550px) {
  .card-panel-description { display: none; }
  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;
    .svg-icon { display: block; margin: 14px auto !important; float: none !important; }
  }
}
</style>
