class ProjectsMonthlyAllocationsController < ApplicationController
  before_action :set_projects_monthly_allocation, only: [:show, :edit, :update, :destroy]

  # GET /projects_monthly_allocations
  # GET /projects_monthly_allocations.json
  def index
    # @projects_monthly_allocations = ProjectsMonthlyAllocation.all

    results = []
    Project.find_each do |project|
      result = {}
      result["id"] = project.id
      result["project_number"] = project.number
      result["project_name"] = project.name
      result["cost"] = project.cost

      sum = 0
      ProjectsMonthlyAllocation.where(project: project).each do |allocation|
        result[allocation.month] = allocation.cost
        sum += allocation.cost
      end

      result["unallocated_cost"] = project.cost - sum
      results << result
    end

    gon.records = results

    gon.options = {
      dataSchema: {
        id:nil,
        project_number:nil,
        project_name:nil,
        cost:nil,
        unallocated_cost:nil,
        "2016-04":nil,
        "2016-05":nil,
        "2016-06":nil,
        "2016-07":nil,
        "2016-08":nil,
        "2016-09":nil,
        "2016-10":nil,
        "2016-11":nil,
        "2016-12":nil,
        "2017-01":nil,
        "2017-02":nil,
        "2017-03":nil
      },
      colHeaders: [
        "案件管理番号",
        "案件名",
        "承認原価",
        "未割当原価",
        "2016-04",
        "2016-05",
        "2016-06",
        "2016-07",
        "2016-08",
        "2016-09",
        "2016-10",
        "2016-11",
        "2016-12",
        "2017-01",
        "2017-02",
        "2017-03"
      ],
      columns: [
        {
          data: "project_number",
          readOnly: true
        },
        {
          data: "project_name",
          readOnly: true
        },
        {
          type: "numeric",
          format: "0.00",
          data: "cost",
          readOnly: true
        },
        {
          type: "numeric",
          format: "0.00",
          data: "unallocated_cost",
          readOnly: true
        },
        {data:"2016-04"},
        {data:"2016-05"},
        {data:"2016-06"},
        {data:"2016-07"},
        {data:"2016-08"},
        {data:"2016-09"},
        {data:"2016-10"},
        {data:"2016-11"},
        {data:"2016-12"},
        {data:"2017-01"},
        {data:"2017-02"},
        {data:"2017-03"}
      ],
    }

  end

  # GET /projects_monthly_allocations/1
  # GET /projects_monthly_allocations/1.json
  def show
  end

  # GET /projects_monthly_allocations/new
  def new
    @projects_monthly_allocation = ProjectsMonthlyAllocation.new
  end

  # GET /projects_monthly_allocations/1/edit
  def edit
  end

  # POST /projects_monthly_allocations
  # POST /projects_monthly_allocations.json
  def create
    @projects_monthly_allocation = ProjectsMonthlyAllocation.new(projects_monthly_allocation_params)

    respond_to do |format|
      if @projects_monthly_allocation.save
        format.html { redirect_to @projects_monthly_allocation, notice: 'Projects monthly allocation was successfully created.' }
        format.json { render :show, status: :created, location: @projects_monthly_allocation }
      else
        format.html { render :new }
        format.json { render json: @projects_monthly_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects_monthly_allocations/1
  # PATCH/PUT /projects_monthly_allocations/1.json
  def update

    error = false
    projects_monthly_allocation_params.each do |month,cost|
      allocation = @project.projects_monthly_allocations.find_by(month: month)
      if allocation
        if cost != ""
          allocation.cost = cost
          allocation.save
        else
          allocation.destroy
        end
      else
        allocation = ProjectsMonthlyAllocation.new
        allocation.project = @project
        allocation.month = month
        allocation.cost = cost
        allocation.save
      end
    end

    respond_to do |format|
      if error
        format.html { render :edit }
        format.json { head :no_content }
      else
        format.html { redirect_to @projects_monthly_allocation, notice: 'Projects monthly allocation was successfully updated.' }
        format.json { head :no_content }
      end
    end

  end

  # DELETE /projects_monthly_allocations/1
  # DELETE /projects_monthly_allocations/1.json
  def destroy
    @projects_monthly_allocation.destroy
    respond_to do |format|
      format.html { redirect_to projects_monthly_allocations_url, notice: 'Projects monthly allocation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_monthly_allocation
      @project = Project.includes(:projects_monthly_allocations).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projects_monthly_allocation_params
      params.permit(:"2016-04",:"2016-05",:"2016-06",:"2016-07",:"2016-08",:"2016-09",:"2016-10",:"2016-11",:"2016-12",:"2017-01",:"2017-02",:"2017-03")
    end
end
