class ProjectsMonthlyAllocationsController < ApplicationController
  before_action :set_projects_monthly_allocation, only: [:show, :edit, :update, :destroy]

  # GET /projects_monthly_allocations
  # GET /projects_monthly_allocations.json
  def index
    # @projects_monthly_allocations = ProjectsMonthlyAllocation.all

    # xs = Project.connection.select_all(<<-SQL).to_a.group_by{|h|h["id"]}
    #   select
    #     a.id as id,
    #     a.number as number,
    #     a.name as name,
    #     a.cost as cost,
    #     sum(b.cost) as planed,
    #     sum(d.cost) as allocated
    #   from projects as a
    #   left join projects_monthly_allocations as b on a.id = b.project_id
    #   left join projects_members as c on a.id = c.project_id
    #   left join projects_members_months as d on c.id = d.projects_member_id
    #   group by a.id
    # SQL

    # ys = Project.connection.select_all(<<-SQL).to_a.group_by{|h|h["id"]}
    #   select
    #     a.id as id,
    #     a.number as number,
    #     b.month as month,
    #     b.cost as cost
    #   from projects as a
    #   inner join projects_monthly_allocations as b on a.id = b.project_id
    # SQL

    # gon.members = Member.connection.select_all(<<-SQL).to_a
    #   select
    #     members.id as id,
    #     members.name as name,
    #     groups.name as group_name,
    #     job_titles.name as job_title_name
    #   from members
    #   left join groups on members.group_id = groups.id
    #   left join job_titles on members.job_title_id = job_titles.id
    #   order by group_id, job_title_id, number, members.name
    # SQL

    # results = []
    # Project.order(:number).each do |project|
    #   result = {}
    #   result["id"] = project.id

    #   path = project_members_allocations_path(project)
    #   result["project_number"] = view_context.link_to project.number, path
    #   result["project_name"] = view_context.link_to project.name, path

    #   result["cost"] = project.cost

    #   sum = 0
    #   ProjectsMonthlyAllocation.where(project: project).each do |allocation|
    #     result[allocation.month] = allocation.cost
    #     sum += allocation.cost
    #   end

    #   result["unallocated_cost"] = project.cost.to_f - sum
    #   results << result
    # end

    gon.records = ProjectsMonthlyAllocation.connection.select_all(<<-SQL).to_a
      select *
      from(
        select
          a.id as id,
          '<a href="/projects/' || a.id || '/members_allocations">' || a.number || '</a>' as number,
          '<a href="/projects/' || a.id || '/members_allocations">' || a.name || '</a>' as name,
          a.cost as cost,
          sum(b.cost) as monthly_allocated_cost,
          sum(case when b.month = '201608' then b.cost end) as "201608",
          sum(case when b.month = '201609' then b.cost end) as "201609",
          sum(case when b.month = '201610' then b.cost end) as "201610",
          sum(case when b.month = '201611' then b.cost end) as "201611",
          sum(case when b.month = '201612' then b.cost end) as "201612",
          sum(case when b.month = '201701' then b.cost end) as "201701",
          sum(case when b.month = '201702' then b.cost end) as "201702",
          sum(case when b.month = '201703' then b.cost end) as "201703",
          sum(case when b.month = '201704' then b.cost end) as "201704",
          sum(case when b.month = '201705' then b.cost end) as "201705",
          sum(case when b.month = '201706' then b.cost end) as "201706",
          sum(case when b.month = '201707' then b.cost end) as "201707"
        from projects as a
        left join projects_monthly_allocations as b on a.id = b.project_id
        group by a.id
        order by a.number
      ) as c
      join(
        select
          d.id as id,
          sum(f.cost) as member_allocated_cost
        from projects as d
        left join projects_members as e on d.id = e.project_id
        left join projects_members_months as f on e.id = f.projects_member_id
        group by d.id
      ) as g
      on c.id = g.id
    SQL

    gon.options = {
      dataSchema: months_schema.merge(
        id:nil,
        number:nil,
        name:nil,
        cost:nil,
        monthly_allocated_cost:nil,
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
          data: "number",
          readOnly: true,
          renderer: "html"
        },
        {
          data: "name",
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
          data: "monthly_allocated_cost",
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


    gon.projects_total = {}

    p = ProjectsMonthlyAllocation.group(:month).sum(:cost)
    m = ProjectsMembersMonth.group(:month).sum(:cost)

    p = p.map{|k,v|[k,v]}.to_h
    m = m.map{|k,v|[k,v]}.to_h

    d = (p.keys|m.keys).map{|k|[k,p[k].to_f - m[k].to_f]}.to_h

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
