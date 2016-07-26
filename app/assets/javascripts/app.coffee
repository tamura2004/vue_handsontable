


$ ->
  vm = new Vue
    el: "#grid"
    data:
      members: []

    created: ->

      @resource = @$resource "members{/id}"

      @resource.get().then(
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
            index = change[0][0]
            member = @members[index]
            if member.id
              @resource.update {id:member.id}, member
            else
              @resource.save(member).then(
                (response) =>
                  @members.$set index, response.data
                  @hot.render()
              )

        (response) ->
          console.log response.data
      )


    methods:
      render: -> @hot.render()

  vm.$watch "members", (n,o) ->
    console.log n
    console.log o



