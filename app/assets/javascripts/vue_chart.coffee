class VueChart
  name: "VueChart"
  props: ['options']
  template: '''
    <div id="chart" style="width:100%; height: 640px;">
    </div>
  '''
  created: ->
    Vue.nextTick =>
      chart = new CanvasJS.Chart "chart", this.options
      chart.render()

Vue.component "vuechart", new VueChart
