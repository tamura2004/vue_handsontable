class ProjectsMembersDecorator < Draper::CollectionDecorator

  HEADERS = [
    "案件管理番号",
    "案件名",
    *MonthTypes.map(&:t),
    "合計"
  ]

  def htbl_options
    HandsonTableBuilder.encode do |json|
      json.colHeaders HEADERS
      json.columns do
        json.column! data: "project_number"
        json.column! data: "project_link", renderer: "html"
        MonthTypes.keys.each do |month|
          json.column! data: month, type: "numeric", format: "0.00"
        end
        json.column! data: "total", type: "numeric", format: "0.00"
      end
      json.columnSorting true
    end
  end

  def allocs_rows
    Jbuilder.encode do |json|
      json.array! map { |assign|
        assign.allocs_row
      }
    end
  end

end
