class PlansController < ApplicationController

  def index
    @plans = Plan.projects
  end

  def compare
    @plans = Plan.compare_with_spro
  end

  def gantt
    @options = Plan.gantt
  end

  def new
    @plan = Plan.new
  end

  PRIME_KEYS = %i(category main_group_name project_number project_name accuracy dept_name group_name sub_number system_name contract_type company_name member_rank)
  
  OTHER_KEYS = %i(unit_price manhour_last_month_landing manhour_performance manhour_development_plan manhour_landing manhour_divergence manhour_ernings money_last_month_landing money_performance money_development_plan money_landing money_divergence money_ernings cost_rate_plan cost_rate_landing gross_profit_plan gross_profit_landing gross_profit_divergence to_be_confirmed m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12)

  ALL_KEYS = PRIME_KEYS + OTHER_KEYS

  def create
    file = params[:plan][:file].path.to_s
    xlsx = Roo::Excelx.new(file)

    xlsx.each_row_streaming do |row|
      @attr = Hash[ALL_KEYS.zip(row.map(&:value))]
      @key = @attr.reject{|k,v| !PRIME_KEYS.include?(k) }
  
      next if @attr[:contract_type] =~ /合計/
      next if @attr[:contract_type] =~ /契約形態/
      next if @attr[:contract_type].nil?

      if @plan = Plan.find_by(@key)
        @plan.update(@attr)
      else
        Plan.create(@attr)
      end
    end
    redirect_to action: :index, status: :ok
  end

end
