class Htbl::ProjectsBuilder < HtblBuilder

  HEADERS = [
    "案件管理番号",
    "案件名",
    *::MonthTypes.map(&:t),
    "合計"
  ]

  def self.htbl_options
    encode do |json|
      json.colHeaders HEADERS
      json.columnSorting true
      json.columns do
        json.column! data: "project_number"
        json.column! data: "project_link", renderer: "html", width: 300
        json.months_columns!
        json.column! data: "total", type: "numeric", format: "0.00"
      end
    end
  end

  def self.allocs(assigns)
    encode do |json|
      json.array! assigns do |assign|
        json.extract! assign, :id, :project_number, :project_link
        json.merge! assign.allocs.pivot
      end
    end
  end

end

