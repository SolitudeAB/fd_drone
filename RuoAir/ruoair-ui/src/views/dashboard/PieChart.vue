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
    height: { type: String, default: '300px' },
    pieData: { type: Array, default: () => [] }
  },
  data() {
    return { chart: null }
  },
  watch: {
    pieData: {
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
      this.setOptions(this.pieData)
    },
    setOptions(data) {
      this.chart.setOption({
        title: { text: '设备状态分布', left: 'center', top: 5, textStyle: { fontSize: 14 } },
        tooltip: { trigger: 'item', formatter: '{b} : {c} ({d}%)' },
        legend: { left: 'center', bottom: 10, data: (data || []).map(d => d.name) },
        series: [{
          type: 'pie',
          roseType: 'radius',
          radius: [15, 95],
          center: ['50%', '45%'],
          data: data,
          animationEasing: 'cubicInOut',
          animationDuration: 2600
        }]
      })
    }
  }
}
</script>
