class Members::Projects::AllocsController < ApplicationController
  def circle_chart
    @members = Member.with_allocs.joins(:allocs).where("projects_members_months.month = ?", "201705").decorate
  end
end
