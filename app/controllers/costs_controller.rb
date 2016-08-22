class CostsController < ApplicationController
  before_action :set_project, only: [:update]
  before_action :set_group, only: [:index,:update]

  # GET /costs
  # GET /costs.json
  def index
    @groups = Group.all

    gon.records = [
      *Project.view.where(group: @group).pivot,
      *Project.total_view.where(group: @group).pivot
    ]

    gon.options = {
      colHeaders: [
        "案件管理番号",
        "案件名",
        *months_headers,
        "合計"
      ],
      columns: [
        {data: "number"},
        {data: "name"},
        *months_columns,
        {data: "total", type: "numeric", format: "0.0"}
      ],
    }

  end

  # GET /costs/1
  # GET /costs/1.json
  def show
  end

  # GET /costs/new
  def new
    @cost = Cost.new
  end

  # GET /costs/1/edit
  def edit
  end

  # POST /costs
  # POST /costs.json
  def create
    @cost = Cost.new(cost_params)

    respond_to do |format|
      if @cost.save
        format.html { redirect_to @cost, notice: 'Cost was successfully created.' }
        format.json { render :show, status: :created, location: @cost }
      else
        format.html { render :new }
        format.json { render json: @cost.errors, status: :unprocessable_entity }
      end
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

  # DELETE /costs/1
  # DELETE /costs/1.json
  def destroy
    @cost.destroy
    respond_to do |format|
      format.html { redirect_to costs_url, notice: 'Cost was successfully destroyed.' }
      format.json { head :no_content }
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
