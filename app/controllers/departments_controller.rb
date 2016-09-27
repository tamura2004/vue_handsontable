class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    @records = Department.all
    @options = {
      dataSchema: {id: nil, name: nil},
      colHeaders: ["部名"],
      columns: [{data: "name"}],
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    render json: @department
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    if @department.save
      render json: @department, status: :ok
    else
      render json: @department.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    if @department.update(department_params)
      render json: @department, status: :ok
    else
      render json: @department.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name)
    end
end
