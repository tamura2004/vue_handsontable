class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    gon.records = Project.connection.select_all(<<-SQL).to_a
      select
        projects.id as id,
        groups.name as group_name,
        number,
        projects.name as name,
        cost,
        rd
      from projects
      left join groups on projects.group_id = groups.id
    SQL

    gon.options = {
      dataSchema: {id: nil, group_name: nil, number: nil, name:nil, cost:nil, rd:nil},
      colHeaders: ["グループ", "案件管理番号", "案件名", "承認原価", "要件定義工数"],
      columns: [
        {
          data: "group_name",
          type: "dropdown",
          source: Group.pluck(:name)
        },
        {data: "number"},
        {data: "name"},
        {data: "cost"},
        {data: "rd"}
      ],
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.permit(:group_name, :number, :name, :rd, :cost)
    end
end
