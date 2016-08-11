class ProjectsMembersController < ApplicationController
  before_action :set_projects_member, only: [:update, :destroy]
  before_action :set_project, only: [:index, :create,:update,:destroy]

  # GET /projects_members
  # GET /projects_members.json
  def index
    gon.members = Member.connection.select_all(<<-SQL).to_a
      select
        members.id as id,
        members.name as name,
        groups.name as group_name,
        job_titles.name as job_title_name
      from members
      left join groups on members.group_id = groups.id
      left join job_titles on members.job_title_id = job_titles.id
      order by group_id, job_title_id, number, members.name
    SQL
    gon.project = @project
    gon.assignments = @project.assignments
  end

  # GET /projects_members/1
  # GET /projects_members/1.json
  def show
  end

  # GET /projects_members/new
  def new
    @projects_member = ProjectsMember.new
  end

  # GET /projects_members/1/edit
  def edit
  end

  # POST /projects_members
  # POST /projects_members.json
  def create
    @assignment = ProjectsMember.new(projects_member_params)

    if @assignment.save
      render json: @assignment, status: :ok
    else
      render json: @assignment.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects_members/1
  # PATCH/PUT /projects_members/1.json
  def update
    respond_to do |format|
      if @projects_member.update(projects_member_params)
        format.html { redirect_to @projects_member, notice: 'Projects member was successfully updated.' }
        format.json { render :show, status: :ok, location: @projects_member }
      else
        format.html { render :edit }
        format.json { render json: @projects_member.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects_members/1
  # DELETE /projects_members/1.json
  def destroy
    @projects_member.destroy
    respond_to do |format|
      format.html { redirect_to projects_members_url, notice: 'Projects member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_member
      @projects_member = ProjectsMember.find(params[:id])
    end

    def set_project
      @project = Project.find_by(id: params[:project_id])
    end

    def set_member
      @member = Member.find_by(id: params[:member_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projects_member_params
      params.require(:projects_member).permit(:project_id, :member_id)
    end
end
