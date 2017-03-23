class VueChart
  name: "VueChart"
  template: '''
    <div id="chart" style="width:320px; height: 240px;">
    </div>
  '''
  created: ->
    Vue.nextTick ->
      chart = new CanvasJS.Chart "chart",
        animationEnabled: true
        theme: "theme4"
        title:
          text: "グラフ表示テスト"
        data: [
          type: "stackedArea"
          dataPoints: [
            label: "apple"
            y: 10
          ,
            label: "orange"
            y: 15
          ,
            label: "banana"
            y: 25
          ,
            label: "mango"
            y: 30
          ,
            label: "grape"
            y: 28
          ]
        ,
          type: "stackedArea"
          dataPoints: [
            label: "apple"
            y: 10
          ,
            label: "orange"
            y: 15
          ,
            label: "banana"
            y: 25
          ,
            label: "mango"
            y: 30
          ,
            label: "grape"
            y: 28
          ]
        ,
          type: "stackedArea"
          dataPoints: [
            label: "apple"
            y: 10
          ,
            label: "orange"
            y: 15
          ,
            label: "banana"
            y: 25
          ,
            label: "mango"
            y: 30
          ,
            label: "grape"
            y: 28
          ]
        ,
          type: "line"
          lineThickness: 8
          markerSize: 16
          dataPoints: [
            label: "apple"
            y: 10
          ,
            label: "orange"
            y: 50
          ,
            label: "banana"
            y: 65
          ,
            label: "mango"
            y: 40
          ,
            label: "grape"
            y: 28
          ]
        ]
      console.log("hi")
      chart.render()

Vue.component "vuechart", new VueChart
