class Members::Projects::AllocsController < ApplicationController
  def circle_chart
    @members = Member.circle_chart.decorate
  end
end
