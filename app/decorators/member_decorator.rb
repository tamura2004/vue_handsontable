class MemberDecorator < Draper::Decorator
  delegate_all

  def text_for_search
    [number, name, job_title.name].join.to_json
  end

end
