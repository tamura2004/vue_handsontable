class Htbl::PlainProjectsBuilder < Htbl::BaseBuilder

  HEADERS = [
    "案件管理番号",
    "案件名",
    "稼動日"
  ]

  def self.htbl_options
    encode do |json|
      json.colHeaders HEADERS
      json.columnSorting true
      json.columns do
        json.column! data: "project_number", width: 200
        json.column! data: "project_link", renderer: "html", width: 600
        json.column! data: "end_month"
      end
    end
  end

  def self.htbl_rows(projects)
    encode do |json|
      json.array! projects do |project|
        json.extract! project, :project_number, :project_link, :end_month
      end
    end
  end

end

