


$ ->
  vm = new Vue
    el: "#grid"
    data:
      members: []

    created: ->

      @$http.get("/members.json").then(
        (response) ->
          @members = response.data
          grid = document.getElementById('grid')
          @hot = new Handsontable grid,
            data: @members
            dataSchema:
              id: null
              name: null
              group: null
              job: null
              number: null
            colHeaders: [
              "所属"
              "職位"
              "社員番号"
              "氏名"
            ]
            columns: [
              {data: "group"},
              {data: "job"},
              {data: "number"},
              {data: "name"}
            ]
            minSpareRows: 1

          @hot.addHook "afterChange", (change,source) =>
            console.log source
            console.log @members[change[0][0]]

        (response) ->
          console.log response.data
      )


    methods:
      render: -> @hot.render()

  vm.$watch "members", (n,o) ->
    console.log n
    console.log o



