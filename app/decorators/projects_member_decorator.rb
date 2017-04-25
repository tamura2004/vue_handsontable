class ProjectsMemberDecorator < Draper::Decorator
  delegate_all
  decorates_association :project
  decorates_association :member
  decorates_association :allocs

  def full_allocs
    MonthTypes.costs(cols: allocs)
  end

  def project_number
    project.try(:number)
  end

  def project_link
    project.try(:link)
  end

  def group_name
    member.try(:group).try(:name)
  end

  def member_number
    member.try(:number)
  end

  def member_name
    member.try(:name)
  end

  def job_title_name
    member.try(:job_title).try(:name)
  end

  def project_number
    project.try(:number)
  end

  def project_name
    project.try(:name)
  end

  # def allocs_row
  #   h.render "assigns/row.json", assign: self, cols: full_allocs
  # end

  def add_series(chart, name)
    chart.add_series(:stackedArea) do |series|
      full_allocs.each_with_index do |cost, i|
        month = MonthTypes.parse(i).key
        series.set_point(month, cost) do |point|
          if month == "201705"
            point[:indexLabel] = name
            point[:indexLabelPlacement] = "outside"
            point[:indexLabelFontSize] = 12
          end
        end
      end
    end
  end

end
