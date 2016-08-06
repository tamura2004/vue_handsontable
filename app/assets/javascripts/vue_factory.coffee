class @VueFactory
  @create: (name) ->
    new Vue
      el: "##{name}"
      data:
        records: gon.records
      created: ->
        @resource = new Resource name
        @hot = new Table name, gon.options, @records, @onChange, @onDelete

      methods:
        onChange: (changes,source) ->
          return if source isnt "edit"
          @handleChange(change) for change in changes

        handleChange: (change)->
          [row,prop,oldVal,newVal] = change
          record = @records[row]
          if record.id? then @update(record,prop,newVal) else @save(record)

          if name is "projects_monthly_allocations"
            record.unallocated_cost += oldVal - newVal
            @hot.hot.render()

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

class Resource
  constructor: (name) -> @resource = Vue.resource "#{name}{/id}"
  handleNormal: (response) -> console.log response
  handleError: (response) -> console.log response
  get: (cb) -> @resource.get().then(cb, @handleError)
  update: (record,prop,newVal) ->
    params = {}
    params[prop] = newVal
    @resource.update(id:record.id,params).then(@handleNormal,@handleError)
  save: (record,cb) -> @resource.save(record).then(cb,@handleError)
  delete: (id) -> @resource.delete(id:id).then(@handleNormal,@handleError)

class Table
  constructor: (@name,@options,@records,onChange,onDelete) ->
    container = document.getElementById @name
    @hot = new Handsontable container, @options
    @hot.loadData(@records)
    @hot.addHook "afterChange", onChange
    @hot.addHook "beforeRemoveRow", onDelete
