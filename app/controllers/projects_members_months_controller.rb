class ProjectsMembersMonthsController < ApplicationController
  before_action :set_project, only: [:index,:create,:update]
  before_action :set_projects_member, only: [:destroy,:update]

  # GET /projects_members_months
  # GET /projects_members_months.json
  def index
    # プロジェクト個別 ----------------------
    result = {}
    result["id"] = @project.id
    result["number"] = @project.number
    result["name"] = @project.name
    @project.projects_monthly_allocations.each do |allocation|
      result[allocation.month] = allocation.cost
    end
    gon.projects_monthly_allocations = {}
    gon.projects_monthly_allocations[:records] = [result]
    gon.projects_monthly_allocations[:options] = {
      dataSchema: months_schema.merge(
        id:nil,
        number:nil,
        name:nil,
        cost:nil
      ),
      colHeaders:[
        "案件管理番号",
        "案件名",
        "総工数",
        *months_headers
      ],
      columns: [
        {
          data: "number",
          disableVisualSelection: true,
          readOnly: true,
        },
        {
          width: 450,
          data: "name",
          disableVisualSelection: true,
          readOnly: true,
        },
        {
          data: "cost",
          type: "numeric",
          format: "0.0",
          disableVisualSelection: true,
          readOnly: true,
        },
        *months_columns
      ]
    }

    # 要員別明細 ---------------------------------
    results = []
    @project.projects_members.each do |assignment|
      result = {}
      result["id"] = assignment.id
      result["member_name"] = assignment.member.name

      ProjectsMembersMonth.where(projects_member: assignment).each do |allocation|
        result[allocation.month] = allocation.cost
      end
      results << result
    end

    gon.records = results

    gon.options = {
      dataSchema: months_schema.merge(
        id:nil,
        member_name:nil
      ),
      colHeaders: [
        "要員名　　　　",
        *months_headers
      ],
      columns: [
        {
          data: "member_name",
          type: "dropdown",
          source: Member.pluck(:name)
        },
        *months_columns
      ],
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }
  end

  # GET /projects_members_months/1
  # GET /projects_members_months/1.json
  def show
  end

  # GET /projects_members_months/new
  def new
    @projects_members_month = ProjectsMembersMonth.new
  end

  # GET /projects_members_months/1/edit
  def edit
  end

  # POST /projects_members_months
  # POST /projects_members_months.json
  def create
    # レコードidがnilの場合呼ばれる
    # その場合、案件と要員のアサインを作成する

    member = Member.find_or_create_by(name: projects_members_month_params[:member_name])

    @projects_member = ProjectsMember.new(member:member,project:@project)

    respond_to do |format|
      if @projects_member.save
        format.html { redirect_to @projects_members_month, notice: 'Projects members month was successfully created.' }
        format.json { render json: @projects_member}
      else
        format.html { render :new }
        format.json { render json: @projects_member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects_members_months/1
  # PATCH/PUT /projects_members_months/1.json
  def update
    error = false
    projects_members_month_params.each do |month,cost|
      @allocation = @projects_member.projects_members_months.find_by(month:month)
      if @allocation
        if cost.to_f > 0
          @allocation.cost = cost
          @allocation.save
        else
          @allocation.destroy
        end
      else
        @allocation = ProjectsMembersMonth.new
        @allocation.projects_member = @projects_member
        @allocation.month = month
        @allocation.cost = cost
        @allocation.save
      end
    end

    respond_to do |format|
      if error
        format.html { render :edit }
        format.json { head :no_content }
      else
        format.html { redirect_to @allocation, notice: 'successfully updated.' }
        format.json { head :no_content }
      end
    end

  end

  # DELETE /projects_members_months/1
  # DELETE /projects_members_months/1.json
  def destroy
    @projects_member.destroy
    respond_to do |format|
      format.html { redirect_to projects_members_months_url, notice: 'Projects members month was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_members_month
      @projects_members_month = ProjectsMembersMonth.find(params[:id])
    end

    def set_projects_member
      @projects_member = ProjectsMember.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projects_members_month_params
      params.permit(:member_name, *months_symbols)
    end

end
