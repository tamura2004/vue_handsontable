


$ ->
  class Table
    constructor: (members) ->
      grid = document.getElementById('grid')
      @hot = new Handsontable grid,
        data: members
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
        contextMenu: true

  vm = new Vue
    el: "#grid"
    data:
      members: []

    created: ->

      @resource = @$resource "members{/id}"

      @resource.get().then(
        (response) =>
          @members = response.data

          @table = new Table @members
          @hot = @table.hot

          @hot.addHook "beforeRemoveRow", (index,amount) =>
            for row in [index..(index+amount-1)]
              id = @members[row].id
              @resource.delete {id:id}

          @hot.addHook "afterChange", (change,source) =>
            console.log change
            index = change[0][0]
            member = @members[index]
            switch source
              when "edit"
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
    # console.log n
    # console.log o



