


$ ->
  new Vue
    el: "#grid"
    data:
      members: [
        {name:'佐藤', number:28}
        {name:'鈴木', number:19}
        {name:'田中', number:25}
      ]

    created: ->
      grid = document.getElementById('grid')
      @hot = new Handsontable grid, {data: @members}

    methods:
      setDataAtCell: (row,col,value) -> @hot.setDataAtCell(row,col,value)



