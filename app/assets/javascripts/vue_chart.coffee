class VueChart
  name: "VueChart"
  props: ['options', 'width', 'height']
  template: '''
    <div
      id="chart"
      :style="{ width: width, height: height }"
    >
    </div>
  '''
  created: ->
    Vue.nextTick =>
      chart = new CanvasJS.Chart "chart", this.options
      chart.render()

Vue.component "vuechart", new VueChart
