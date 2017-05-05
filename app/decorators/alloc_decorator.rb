class AllocDecorator < Draper::Decorator
  delegate_all

  def group_name
    assign&.member&.group&.name
  end

  def member_number
    assign&.member&.number
  end

  def member_name
    assign&.member&.name
  end

  def job_title_name
    assign&.member&.job_title&.name
  end

  def project_number
    assign&.project&.number
  end

  def project_name
    assign&.project&.name
  end

  def date
    sprintf("%s/%s/%s",month[0,4],month[4,2],1)
  end

end
