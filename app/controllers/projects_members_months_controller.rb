class ProjectsMembersMonthsController < ApplicationController
  before_action :set_project, only: [:index,:create,:update]
  before_action :set_projects_member, only: [:destroy,:update]

  # GET /projects_members_months
  # GET /projects_members_months.json
  def index
    gon.allocations = {}
    gon.allocations[:records] =
      Project.view
        .where(id: @project)
        .pivot

    gon.allocations[:options] = {
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
        {data: "number"},
        {data: "name"},
        {
          data: "projects_cost",
          type: "numeric",
          format: "0.0",
        },
        *months_columns
      ]
    }

    gon.records = ProjectsMember.member_view
      .where("projects_members.project_id = ?",@project)
      .pivot

    gon.options = {
      colHeaders: [
        "所属",
        "職位",
        "社員番号",
        "氏名",
        *months_headers
      ],
      columns: [
        {data:"group"},
        {data:"job"},
        {data:"number"},
        {
          data: "name",
        },
        *months_columns
      ]
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

    # member = Member.find_or_create_by(name: projects_members_month_params[:member_name])
    member = Member.find_by(name: projects_members_month_params[:member_name])

    @projects_member = ProjectsMember.new(member:member,project:@project)

    respond_to do |format|
      if @projects_member.save
        format.html { redirect_to @projects_members_month, notice: 'Projects members month was successfully created.' }
        format.json { render json: @projects_member}
      else
        format.html { render :new }
        format.json { render json: @projects_member.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects_members_months/1
  # PATCH/PUT /projects_members_months/1.json
  def update

    # アサイン先メンバーの変更
    if params.has_key? :member_name
      @projects_member.member = Member.find_by(name: params[:member_name])
      if @projects_member.save
        render json: @projects_member, status: :ok
      else
        render json: @projects_member.errors.full_messages, status: :unprocessable_entity
      end

    # アサインに紐づいた月別の工数を変更
    else
      month = projects_members_month_params.keys.try(:first)
      cost = projects_members_month_params.values.try(:first)

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
