class ProjectsMembersController < ApplicationController
  before_action :set_projects_member, only: [:show, :edit, :update, :destroy]

  # GET /projects_members
  # GET /projects_members.json
  def index
    @projects_members = ProjectsMember.all
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
    @projects_member = ProjectsMember.new(projects_member_params)

    respond_to do |format|
      if @projects_member.save
        format.html { redirect_to @projects_member, notice: 'Projects member was successfully created.' }
        format.json { render :show, status: :created, location: @projects_member }
      else
        format.html { render :new }
        format.json { render json: @projects_member.errors, status: :unprocessable_entity }
      end
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
        format.json { render json: @projects_member.errors, status: :unprocessable_entity }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def projects_member_params
      params.require(:projects_member).permit(:project_id, :member_id)
    end
end
