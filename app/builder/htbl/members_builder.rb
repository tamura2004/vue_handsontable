class Htbl::MembersBuilder < HtblBuilder

  HEADERS = [
    "職位",
    "社員番号",
    "社員名",
    *::MonthTypes.map(&:t),
    "合計"
  ]

  def self.htbl_options
    encode do |json|
      json.colHeaders HEADERS
      json.columnSorting true
      json.columns do
        json.column! data: "job_title_link", renderer: "html"
        json.column! data: "member_number"
        json.column! data: "member_link", renderer: "html"
        json.months_columns!
        json.column! data: "total", type: "numeric", format: "0.00"
      end
    end
  end

  def self.allocs(members)
    encode do |json|
      json.array! members do |member|
        json.extract! member, :id, :member_number, :member_link, :job_title_link
        json.merge! member.allocs.pivot
      end
    end
  end

end
