class MemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :job_title
  decorates_association :projects
  decorates_association :assigns

  def member_number
    number
  end

  def member_name
    name
  end

  def member_link
    link
  end

  def text_for_search
    full_name.to_json
  end

  def full_name
    [number, name].join(" ")
  end

  def job_title_name
    job_title.try(:name) || ""
  end

  def group_name
    group.try(:name) || ""
  end

  def link
    h.link_to name, h.member_allocs_path(id)
  end

  def job_title_link
    job_title&.link(group)
  end

  def label
    Jbuilder.encode do |json|
      json.extract! self, :id, :number, :name, :job_title_name, :group_name
    end
  end

  def work_cost(month = nil)
    month ||= Date.today.strftime("%Y%m")
    works.find_by(month: month)&.cost || 0
  end

end
