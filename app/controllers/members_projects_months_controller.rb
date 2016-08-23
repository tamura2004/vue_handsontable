class MembersProjectsMonthsController < ApplicationController
  before_action :set_member, only: [:index,:create,:update]
  before_action :set_projects_member, only: [:update,:destroy]

  # GET /members_projects_months
  # GET /members_projects_months.json
  def index
    # 要員個別 -----------------------
    result = Hash.new(0)
    result["id"] = @member.id
    result["group_name"] = @member.group.name
    result["job_title_name"] = @member.job_title.name
    result["number"] = @member.number
    result["name"] = @member.name

    @member.projects_members.each do |assignment|
      assignment.projects_members_months.each do |allocation|
        result[allocation.month] += allocation.cost.to_f
      end
    end
    gon.members_months = {}
    gon.members_months[:records] = [result]
    gon.members_months[:options] = {
      dataSchema: months_schema.merge(
        id:nil,
        group_name:nil,
        job_title_name: nil,
        number: nil,
        name: nil
      ),
      colHeaders: [
        "所属",
        "職位",
        "社員番号",
        "氏名",
        *months_headers
      ],
      columns: [
        {
          data: "group_name",
          renderer: "html"
        },
        {
          data: "job_title_name",
          renderer: "html"
        },
        {
          data: "number",
        },
        {
          data: "name",
          renderer: "html"
        },
        *months_immutable_columns
      ],
    }

    # 案件別明細 ---------------------------------
    results = []
    @member.projects_members.each do |assignment|
      result = {}
      result["id"] = assignment.id
      result["project_number"] = assignment.project.try(:number)
      result["project_name"] = assignment.project.try(:name)

      ProjectsMembersMonth.where(projects_member: assignment).each do |allocation|
        result[allocation.month] = allocation.cost
      end
      results << result
    end

    gon.records = results

    gon.options = {
      dataSchema: months_schema.merge(
        id:nil,
        project_number:nil,
        project_name:nil
      ),
      colHeaders: [
        "案件名",
        *months_headers
      ],
      columns: [
        {
          data: "project_name",
          type: "dropdown",
          source: Project.pluck(:name)
        },
        *months_columns
      ],
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }
  end

  # GET /members_projects_months/1
  # GET /members_projects_months/1.json
  def show
  end

  # GET /members_projects_months/new
  def new
    @members_projects_month = MembersProjectsMonth.new
  end

  # GET /members_projects_months/1/edit
  def edit
  end

  # POST /members_projects_months
  # POST /members_projects_months.json
  def create
    # レコードidがnilの場合呼ばれる
    # その場合、案件と要員のアサインを作成する

    # project = Project.find_or_create_by(name: members_projects_month_params[:project_name])
    project = Project.find_by(name: members_projects_month_params[:project_name])

    @projects_member = ProjectsMember.new(project:project,member:@member)

    respond_to do |format|
      if @projects_member.save
        format.html { redirect_to @members_projects_month, notice: 'Members projects month was successfully created.' }
        format.json { render json: @projects_member, status: :ok }
      else
        format.html { render :new }
        format.json { render json: @projects_member.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members_projects_months/1
  # PATCH/PUT /members_projects_months/1.json
  def update

        # アサイン先メンバーの変更
    if params.has_key? :project_name
      @projects_member.project = Project.find_by(name: params[:project_name])
      if @projects_member.save
        render json: @projects_member, status: :ok
      else
        render json: @projects_member.errors.full_messages, status: :unprocessable_entity
      end

    # アサインに紐づいた月別の工数を変更
    else
      month = members_projects_month_params.keys.try(:first)
      cost = members_projects_month_params.values.try(:first)

      @allocation = ProjectsMembersMonth.find_by(projects_member: @projects_member, month: month)

      # 工数を更新
      if @allocation
        if cost.to_f > 0
          if @allocation.update(cost: cost)
            render json: @allocation, status: :ok
          else
            render json: @allocation.errors.full_messages, status: :unprocessable_entity
          end
        else
          @allocation.destroy
          head :no_content
        end

      # 工数を登録
      else
        @allocation = ProjectsMembersMonth.new(projects_member: @projects_member, month: month, cost: cost)
        if @allocation.save
          render json: @allocation, status: :ok
        else
          render json: @allocation.errors.full_messages, status: :unprocessable_entity
        end
      end
    end

  end

  # DELETE /members_projects_months/1
  # DELETE /members_projects_months/1.json
  def destroy
    @projects_member.destroy
    respond_to do |format|
      format.html { redirect_to members_projects_months_url, notice: 'Members projects month was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_member
      @projects_member = ProjectsMember.find(params[:id])
    end

    def set_member
      @member = Member.find(params[:member_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def members_projects_month_params
      params.permit(:project_name,*months_symbols)
    end
end
