class CostsController < ApplicationController
  before_action :set_project, only: [:update]
  before_action :set_group, only: [:index,:update]

  # GET /costs
  # GET /costs.json
  def index
    @groups = Group.all

    @records =
      VCost
        .select(
          :project_number,
          :project_link,
          :month,
          :cost
        )
        .select("project_id as id")
        .order(:project_number)
        .where(group_id: @group)
        .pivot
        .to_json

    @options = {
      colHeaders: [
        "案件管理番号",
        "案件名",
        *months_headers,
        "合計"
      ],
      columns: [
        {data: "project_number"},
        {data: "project_link", renderer: "html"},
        *months_columns,
        {data: "total", type: "numeric", format: "0.0"}
      ],
    }.to_json

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
