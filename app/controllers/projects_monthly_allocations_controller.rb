class ProjectsMonthlyAllocationsController < ApplicationController
  before_action :set_projects_monthly_allocation, only: [:show, :edit, :update, :destroy]

  # GET /projects_monthly_allocations
  # GET /projects_monthly_allocations.json
  def index
    gon.records = ProjectsMonthlyAllocation.connection.select_all(<<-"SQL").to_a
      select
        id,
        number,
        '<a href="/projects/' || id || '/members_allocations">' || number || '</a>' as number_link,
        '<a href="/projects/' || id || '/members_allocations">' || name || '</a>' as name_link,
        cost,
        project_cost.*,
        member_cost.*
      from projects
      left join (
        select
          project_id,
          sum(cost) as total,
          #{months_pivot_sql}
        from projects_monthly_allocations
        group by project_id
      ) project_cost on projects.id = project_cost.project_id
      left join (
        select
          project_id,
          sum(cost) as member_allocated_cost
        from projects_members
        inner join projects_members_months on projects_members.id = projects_member_id
        group by project_id
      ) member_cost on projects.id = member_cost.project_id
      order by number
    SQL
      

    gon.options = {
      dataSchema: months_schema.merge(
        id:nil,
        number_link:nil,
        name_link:nil,
        cost:nil,
        total:nil,
        member_allocated_cost:nil
      ),
      colHeaders: [
        "案件管理番号",
        "案件名",
        "総工数",
        "月割当",
        "要員割当",
        *months_headers
      ],
      columns: [
        {
          data: "number_link",
          readOnly: true,
          renderer: "html"
        },
        {
          data: "name_link",
          readOnly: true,
          renderer: "html"
        },
        {
          type: "numeric",
          format: "0.0",
          data: "cost",
          readOnly: true
        },
        {
          type: "numeric",
          format: "0.0",
          data: "total",
          readOnly: true
        },
        {
          type: "numeric",
          format: "0.0",
          data: "member_allocated_cost",
          readOnly: true
        },
        *months_columns
      ],
    }

    p = ProjectsMonthlyAllocation.connection.select_all(<<-"SQL").to_a.first
      select
        sum(cost) as total,
        #{months_pivot_sql}
      from projects_monthly_allocations
    SQL

    m = ProjectsMembersMonth.connection.select_all(<<-"SQL").to_a.first
      select
        sum(cost) as total,
        #{months_pivot_sql}
      from projects_members_months
      inner join projects_members on projects_members.id = projects_member_id
    SQL

    gon.projects_total = {}
    gon.projects_total["records"] = [p,m]

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
