class ProjectsMembersMothlyAllocationsController < ApplicationController
  before_action :set_projects_members_mothly_allocation, only: [:show, :edit, :update, :destroy]

  # GET /projects_members_mothly_allocations
  # GET /projects_members_mothly_allocations.json
  def index
    @projects_members_mothly_allocations = ProjectsMembersMothlyAllocation.all
  end

  # GET /projects_members_mothly_allocations/1
  # GET /projects_members_mothly_allocations/1.json
  def show
  end

  # GET /projects_members_mothly_allocations/new
  def new
    @projects_members_mothly_allocation = ProjectsMembersMothlyAllocation.new
  end

  # GET /projects_members_mothly_allocations/1/edit
  def edit
  end

  # POST /projects_members_mothly_allocations
  # POST /projects_members_mothly_allocations.json
  def create
    @projects_members_mothly_allocation = ProjectsMembersMothlyAllocation.new(projects_members_mothly_allocation_params)

    respond_to do |format|
      if @projects_members_mothly_allocation.save
        format.html { redirect_to @projects_members_mothly_allocation, notice: 'Projects members mothly allocation was successfully created.' }
        format.json { render :show, status: :created, location: @projects_members_mothly_allocation }
      else
        format.html { render :new }
        format.json { render json: @projects_members_mothly_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects_members_mothly_allocations/1
  # PATCH/PUT /projects_members_mothly_allocations/1.json
  def update
    respond_to do |format|
      if @projects_members_mothly_allocation.update(projects_members_mothly_allocation_params)
        format.html { redirect_to @projects_members_mothly_allocation, notice: 'Projects members mothly allocation was successfully updated.' }
        format.json { render :show, status: :ok, location: @projects_members_mothly_allocation }
      else
        format.html { render :edit }
        format.json { render json: @projects_members_mothly_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects_members_mothly_allocations/1
  # DELETE /projects_members_mothly_allocations/1.json
  def destroy
    @projects_members_mothly_allocation.destroy
    respond_to do |format|
      format.html { redirect_to projects_members_mothly_allocations_url, notice: 'Projects members mothly allocation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projects_members_mothly_allocation
      @projects_members_mothly_allocation = ProjectsMembersMothlyAllocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def projects_members_mothly_allocation_params
      params.require(:projects_members_mothly_allocation).permit(:project_id, :member_id, :month, :cost)
    end
end
