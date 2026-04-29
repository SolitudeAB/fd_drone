<template>
  <div :class="className" :style="{height:height,width:width}" />
</template>

<script>
import * as echarts from 'echarts'
require('echarts/theme/macarons')
import resize from './mixins/resize'

export default {
  mixins: [resize],
  props: {
    className: { type: String, default: 'chart' },
    width: { type: String, default: '100%' },
    height: { type: String, default: '350px' },
    lineData: { type: Array, default: () => [] }
  },
  data() {
    return { chart: null }
  },
  watch: {
    lineData: {
      deep: true,
      handler(val) { this.setOptions(val) }
    }
  },
  mounted() {
    this.$nextTick(() => { this.initChart() })
  },
  beforeDestroy() {
    if (this.chart) { this.chart.dispose(); this.chart = null }
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$el, 'macarons')
      this.setOptions(this.lineData)
    },
    setOptions(data) {
      const days = (data || []).map(d => d.name || d.day || '')
      const values = (data || []).map(d => d.value || d.count || 0)
      this.chart.setOption({
        title: { text: '近7天任务趋势', left: 'center', top: 5, textStyle: { fontSize: 14 } },
        xAxis: {
          data: days,
          boundaryGap: false,
          axisTick: { show: false }
        },
        grid: { left: 10, right: 20, bottom: 20, top: 45, containLabel: true },
        tooltip: { trigger: 'axis', axisPointer: { type: 'cross' }, padding: [5, 10] },
        yAxis: { axisTick: { show: false }, minInterval: 1 },
        series: [{
          name: '任务数',
          smooth: true,
          type: 'line',
          data: values,
          itemStyle: { color: '#409EFF' },
          areaStyle: { color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: 'rgba(64,158,255,0.3)' },
            { offset: 1, color: 'rgba(64,158,255,0.05)' }
          ])},
          animationDuration: 2800,
          animationEasing: 'quadraticOut'
        }]
      })
    }
  }
}
</script>
