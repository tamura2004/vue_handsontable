class ProjectsMonthlyAllocationsController < ApplicationController
  before_action :set_projects_monthly_allocation, only: [:show, :edit, :update, :destroy]

  # GET /projects_monthly_allocations
  # GET /projects_monthly_allocations.json
  def index
    # @projects_monthly_allocations = ProjectsMonthlyAllocation.all

    results = []
    Project.order(:number).each do |project|
      result = {}
      result["id"] = project.id

      path = project_members_allocations_path(project)
      result["project_number"] = view_context.link_to project.number, path
      result["project_name"] = view_context.link_to project.name, path

      result["cost"] = project.cost

      sum = 0
      ProjectsMonthlyAllocation.where(project: project).each do |allocation|
        result[allocation.month] = allocation.cost
        sum += allocation.cost
      end

      result["unallocated_cost"] = project.cost.to_f - sum
      results << result
    end

    gon.records = results

    gon.options = {
      dataSchema: months_schema.merge(
        id:nil,
        project_number:nil,
        project_name:nil,
        cost:nil,
        unallocated_cost:nil
      ),
      colHeaders: [
        "案件管理番号",
        "案件名",
        "総工数",
        "未割当",
        *months_headers
      ],
      columns: [
        {
          data: "project_number",
          disableVisualSelection: true,
          readOnly: true,
          renderer: "html"
        },
        {
          data: "project_name",
          disableVisualSelection: true,
          readOnly: true,
          renderer: "html"
        },
        {
          type: "numeric",
          format: "0.0",
          data: "cost",
          disableVisualSelection: true,
          readOnly: true
        },
        {
          type: "numeric",
          format: "0.0",
          data: "unallocated_cost",
          disableVisualSelection: true,
          readOnly: true
        },
        *months_columns
      ],
    }


    gon.projects_total = {}

    p = ProjectsMonthlyAllocation.group(:month).sum(:cost)
    m = ProjectsMembersMonth.group(:month).sum(:cost)
    d = (p.keys|m.keys).map{|k|[k,p[k].to_i - m[k].to_i]}.to_h

    pt = ProjectsMonthlyAllocation.sum(:cost)
    mt = ProjectsMembersMonth.sum(:cost)
    dt = pt - mt

    gon.projects_total["records"] = [
      p.merge(
        name: "案件原価合計",
        total: pt
      ),
      m.merge(
        name: "要員割当合計",
        total: mt
      ),
      d.merge(
        name: "未割当",
        total: dt
      )
    ]

    gon.projects_total["options"] = {
      dataSchema: months_schema.merge(
        name:nil,
        total:nil
      ),
      colHeaders: [
        "区分",
        "合計",
        *months_headers
      ],
      columns: [
        {
          data: "name",
          readOnly: true
        },
        {
          data: "total",
          readOnly: true,
          type: "numeric",
          format: "0.00"
        },
        *months_columns
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
        format.json { render json: @projects_monthly_allocation.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects_monthly_allocations/1
  # PATCH/PUT /projects_monthly_allocations/1.json
  def update

    @status = true

    projects_monthly_allocation_params.each do |month,cost|
      @allocation = @project.projects_monthly_allocations.find_by(month: month)
      if @allocation
        if cost.to_f > 0
          @allocation.cost = cost
          @status = @allocation.save
        else
          @status = @allocation.destroy
        end
      else
        if cost.to_f > 0
          @allocation = ProjectsMonthlyAllocation.new
          @allocation.project = @project
          @allocation.month = month
          @allocation.cost = cost
          @status = @allocation.save
        end
      end
    end

    respond_to do |format|
      if @status
        format.html { render :edit }
        format.json { render json: @allocation, status: :ok}
      else
        format.html { redirect_to @projects_monthly_allocation, notice: 'Projects monthly allocation was successfully updated.' }
        format.json { render json: @allocation.errors.full_messages, status: :unprocessable_entity }
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
      params.permit(months_symbols)
    end

end
