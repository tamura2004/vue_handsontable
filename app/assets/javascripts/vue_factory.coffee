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
  props:
    rows: Array
    opts: Object
    ctl: String
    total:
      type: Boolean
      default: true

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
          if k.match(/20\d\d\d\d/) or k is "total"
            if typeof(v) is "number"
              if total[k]?
                total[k] += v
              else
                total[k] = v
          else
            if k isnt "id"
              total[k] = "合計"

      if @total
        rows.concat(total)
      else
        rows

  ready: ->
    @resource = new Resource @ctl if @ctl?
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
      console.log change
      [row,prop,oldVal,newVal] = change
      record = @records[row]

      if record.id? then @update(record,prop,newVal) else @save(record)

    update: (record,prop,newVal) ->
      if @resource
        @resource.update record,prop,newVal

    save: (record) ->
      if @resource
        @resource.save record, (response) =>
          record.id = response.data.id

    onDelete: (index,amount) ->
      if @resource
        for i in [index..(index+amount-1)]
          record = @records[i]
          return unless record.id?
          @resource.delete record.id

class Whereareyou
  template: '''
    <h4>{{member.name}}</4>
    <select v-model="state" class="btn btn-block" :class="state">
      <option value="btn-default">
        <h4>田村</h4>
        帰宅
      </option>
      <option value="btn-primary">
        在籍
      </option>
      <option value="btn-success">
        すぐ戻る
      </option>
      <option value="btn-info">
        会議中
      </option>
      <option value="btn-warning">
        休憩中
      </option>
      <option value="btn-danger">
        休み
      </option>
    </select>
  '''
  props: ['member']

$ ->
  new Vue
    el: "body"
    data:
      query: ""
    components:
      htbl: new VueTable
      wbtn: new Whereareyou
