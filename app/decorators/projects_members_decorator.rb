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

  # def members
  #   MembersDecorator.new(map(&:member))
  # end

  # def projects
  #   ProjectsDecorator.new(map(&:project))
  # end

  # def allocs_rows
  #   h.render "/assigns/row.json", assigns: self
  # end

  def members_allocs_rows
    h.render "/assigns/members/row.json", assigns: self
  end

  def projects_allocs_rows
    h.render "/assigns/projects/row.json", assigns: self
  end
end
