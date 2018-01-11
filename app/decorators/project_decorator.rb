class ProjectDecorator < Draper::Decorator
  delegate_all
  decorates_association :assigns
  
  def text_for_search
    [number, name].join.to_json
  end

  def full_name
    [number, name].join(" ")
  end

  def link
    h.link_to name, h.project_allocs_path(id)
  end

  def project_number
    number
  end

  def project_name
    name
  end

  def project_link
    link
  end

  def month
    if end_month.present?
      "%s-%s" % [end_month[0,4], end_month[4,2]]
    else
      ""
    end
  end

end
