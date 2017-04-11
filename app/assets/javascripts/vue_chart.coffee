class VueChart
  name: "VueChart"
  props: ['options', 'width', 'height', 'uuid']
  template: '''
    <div :id="uuid" :style="{width: width, height: height}">
    </div>
  '''
  created: ->
    if this.options.data[0].type is "rangeBar"
      this.options =
        title:
          text: "test"
        axisY:
          interval: 1
        axisX:
          interval: 1
        data: [
          type: "rangeBar"
          dataPoints: [
            x: 1
            y: [1,2]
          ,
            x: 2
            y: [2,3]
          ,
            x: 3
            y: [3,4]
          ]
        ]
    Vue.nextTick =>
      chart = new CanvasJS.Chart this.uuid, this.options
      chart.render()

Vue.component "vuechart", new VueChart
