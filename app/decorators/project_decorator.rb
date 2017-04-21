class ProjectDecorator < Draper::Decorator
  delegate_all

  def text_for_search
    [number, name].join.to_json
  end

end
