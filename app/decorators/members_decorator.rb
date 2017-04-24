class MembersDecorator < Draper::CollectionDecorator

  HEADERS = [
    "職位",
    "社員番号",
    "社員名",
    *MonthTypes.map(&:t),
    "合計"
  ]

  def htbl_options
    HandsonTableBuilder.encode do |json|
      json.colHeaders HEADERS
      json.columns do
        json.column! data: "job_title_link", renderer: "html"
        json.column! data: "member_number"
        json.column! data: "member_link", renderer: "html"
        MonthTypes.keys.each do |month|
          json.column! data: month, type: "numeric", format: "0.00"
        end
        json.column! data: "total", type: "numeric", format: "0.00"
      end
      json.columnSorting true
    end
  end

  def works_rows
    h.render "/members/works/rows.json", members: self
    # h.render partial: ""
    # Jbuilder.encode do |json|
    #   json.array! map{ |member|
    #     member.works_row
    #   }
    # end
  end

  def allocs_rows
    h.render partial: "/members/row.json", collection: self, as: :member, locals: { coltype: :full_allocs }
    # Jbuilder.encode do |json|
    #   json.array! map { |member|
    #     member.allocs_row
    #   }
    # end
  end

end
