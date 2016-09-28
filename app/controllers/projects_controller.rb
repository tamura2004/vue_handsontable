class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @records = Project.connection.select_all(<<-SQL).to_a
      select
        projects.id as id,
        groups.name as group_name,
        number,
        projects.name as name,
        cost,
        rd
      from projects
      left join groups on projects.group_id = groups.id
      order by group_id, number
    SQL

    @options = {
      dataSchema: {id: nil, group_name: nil, number: nil, name:nil, cost:nil, rd:nil},
      colHeaders: ["グループ", "案件管理番号", "案件名", "承認原価", "要件定義工数"],
      columns: [
        {
          data: "group_name",
          type: "dropdown",
          source: Group.pluck(:name)
        },
        {data: "number"},
        {
          data: "name"
        },
        {data: "cost"},
        {data: "rd"}
      ],
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :ok
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    head :no_content
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
