class VueFactory
  @create: (name) ->
    new Vue
      el: "##{name}"
      data:
        records: []

      created: ->
        @resource = new Resource name
        @resource.get (response) =>
          @records = response.data
          @hot = new Table name, OPTIONS[name], @records, @onChange, @onDelete
      methods:
        onChange: (changes,source) =>
          console.log changes
          return if source isnt "edit"
          for change in changes
            i = change[0]
            record = @records[i]
            if record.id?
              @resource.update record
            else
              @resource.save record, (response) =>
                @records.$set i, response.data

        onDelete: (index,amount) =>
          for i in [index..(index+amount-1)]
            record = @records[i]
            return unless record.id?
            @resource.delete record.id

class Resource
  constructor: (name) -> @resource = Vue.resource "#{name}{/id}"
  handleError: (response) -> console.log response
  get: (cb) -> @resource.get().then(cb, @handleError)
  update: (record,cb) -> @resource.update(id:record.id,record).then(cb,@handleError)
  save: (record,cb) -> @resource.save(record).then(cb,@handleError)
  delete: (id) -> @resource.delete(id:id).then(null,@handleError)

class Table
  constructor: (@name,@options,@records,onChange,onDelete) ->
    container = document.getElementById @name
    @hot = new Handsontable container, @options
    @hot.loadData(@records)
    @hot.addHook "afterChange", onChange
    @hot.addHook "beforeRemoveRow", onDelete

OPTIONS =
  members:
    dataSchema: {id: null, name: null, group: null, job: null, number: null}
    colHeaders: ["所属", "職位", "社員番号", "氏名"]
    columns: [{data: "group"}, {data: "job"}, {data: "number"}, {data: "name"}]
    minSpareRows: 1
    contextMenu: ["remove_row"]

$ -> VueFactory.create "members"
