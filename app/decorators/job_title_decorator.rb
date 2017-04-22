class JobTitleDecorator < Draper::Decorator
  delegate_all

  def link(group)
    h.link_to name, h.group_job_title_allocs_path(group, id)
  end

end
