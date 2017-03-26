class VueChart
  name: "VueChart"
  props: ['options', 'width', 'height', 'uuid']
  template: '''
    <div :id="uuid" :style="{width: width, height: height}">
    </div>
  '''
  created: ->
    Vue.nextTick =>
      chart = new CanvasJS.Chart this.uuid, this.options
      chart.render()

Vue.component "vuechart", new VueChart
