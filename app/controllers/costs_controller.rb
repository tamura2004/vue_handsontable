class CostsController < ApplicationController
  before_action :set_project, only: [:update]
  before_action :set_group, only: [:index]

  # GET /costs
  # GET /costs.json
  def index
    @groups = Group.all

    @costs = HtblParamsFactory.new do |t|
      t.model = VCost.where(group_id: @group).order(:project_number)
      t.id_field = :project_id
      t.fields = :project_number, :project_link
    end

  end

  # PATCH/PUT /costs/1
  # PATCH/PUT /costs/1.json
  def update
    month = cost_params.keys.try(:first)
    cost = cost_params.values.try(:first)

    @cost = ProjectsMonthlyAllocation.find_by(project: @project, month: month)

    if @cost
      if cost.to_f > 0
        if @cost.update(cost: cost)
          render json: @cost, status: :ok
        else
          render json: @cost.errors.full_messages, status: :unprocessable_entity
        end
      else
        @cost.destroy
        head :no_content
      end

    else
      @cost = ProjectsMonthlyAllocation.new(project: @project, month: month, cost: cost)
      if @cost.save
        render json: @cost, status: :ok
      else
        render json: @cost.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cost_params
      params.permit(months_symbols)
    end
end
