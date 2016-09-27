class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @records = Group.connection.select_all(<<-SQL).to_a
      select
        groups.id as id,
        departments.name as department_name,
        groups.name as name
      from groups
      left join departments on groups.department_id = departments.id
    SQL

    @options = {
      dataSchema: {id: nil, department_name:nil, name: nil},
      colHeaders: ["部名","グループ名"],
      columns: [
        {
          data: "department_name",
          type: "dropdown",
          source: Department.pluck(:name)
        },
        {data: "name"}
      ],
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }
  end

  # GET /groups/1.json
  def show
    render json: @group
  end

  # POST /groups.json
  def create
    @group = Group.new(group_params)

    if @group.save
      render json: @group, status: :ok
    else
      render json: @group.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1.json
  def update
    if @group.update(group_params)
      render json: @group, status: :ok
    else
      render json: @group.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /groups/1.json
  def destroy
    @group.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.permit(:department_name, :name)
    end
end
