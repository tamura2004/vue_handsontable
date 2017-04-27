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
        json.column! data: "project_link", renderer: "html"
        json.months_columns!
        json.column! data: "total", type: "numeric", format: "0.00"
      end
    end
  end

end

