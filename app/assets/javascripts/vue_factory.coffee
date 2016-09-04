class @Resource
  constructor: (name) -> @resource = Vue.resource "#{name}{/id}"
  handleNormal: (response) -> console.log response.data
  handleError: (response) -> alert response.data
  get: (cb) -> @resource.get().then(cb, @handleError)
  update: (record,prop,newVal) ->
    params = {}
    params[prop] = newVal
    @resource.update(id:record.id,params).then(@handleNormal,@handleError)
  save: (record,cb) -> @resource.save(record).then(cb,@handleError)
  delete: (id) -> @resource.delete(id:id).then(@handleNormal,@handleError)

class VueTable
  template: '<div></div>'
  props: ['rows','opts','ctl']
  computed:
    records: ->
      # フィルタ
      rows = @rows.filter (r) =>
        (v for k,v of r).some (v) =>
          typeof(v) is "string" and v.indexOf(@$parent.query) isnt -1

      # 行合計
      for row in rows
        row.total = 0
        for k,v of row
          if k.match(/20\d\d\d\d/) and typeof(v) is "number"
            row.total += v

      # 列合計
      total = {}
      for row in rows
        for k,v of row
          if k.match(/20\d\d\d\d/)
            if typeof(v) is "number"
              if total[k]?
                total[k] += v
              else
                total[k] = v
          else
            if k isnt "id"
              total[k] = "合計"

      rows.concat(total)

  ready: ->
    @resource = new Resource @ctl
    @hot = new Handsontable @$el,@opts
    @hot.loadData @records
    @hot.addHook "afterChange", @onChange
    @hot.addHook "beforeRemoveRow", @onDelete
    @$watch "records", (n,v) => @refresh()

  methods:
    refresh: ->
      @hot.loadData @records
      @hot.render()

    onChange: (changes,source) ->
      if source in ["edit","autofill","paste"]
        @handleChange(change) for change in changes

    handleChange: (change)->
      [row,prop,oldVal,newVal] = change
      record = @records[row]

      if oldVal is null and record.id?
        id = @rows.find((r)->r.id is record.id).id
        @$set "rows[id]", newVal

      if record.id? then @update(record,prop,newVal) else @save(record)

    update: (record,prop,newVal) ->
      @resource.update record,prop,newVal

    save: (record) ->
      @resource.save record, (response) =>
        record.id = response.data.id

    onDelete: (index,amount) ->
      for i in [index..(index+amount-1)]
        record = @records[i]
        return unless record.id?
        @resource.delete record.id

$ ->
  new Vue
    el: "body"
    data:
      query: ""

    components:
      htbl: new VueTable

