class ProjectsMembersMonthsController < ApplicationController
  before_action :set_projects_members_month, only: [:show, :edit, :update, :destroy]

  # GET /projects_members_months
  # GET /projects_members_months.json
  def index
    results = []
    @project = Project.find(params[:project_id])
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
    @projects_members_month = ProjectsMembersMonth.new(projects_members_month_params)

    respond_to do |format|
      if @projects_members_month.save
        format.html { redirect_to @projects_members_month, notice: 'Projects members month was successfully created.' }
        format.json { render :show, status: :created, location: @projects_members_month }
      else
        format.html { render :new }
        format.json { render json: @projects_members_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects_members_months/1
  # PATCH/PUT /projects_members_months/1.json
  def update
    respond_to do |format|
      if @projects_members_month.update(projects_members_month_params)
        format.html { redirect_to @projects_members_month, notice: 'Projects members month was successfully updated.' }
        format.json { render :show, status: :ok, location: @projects_members_month }
      else
        format.html { render :edit }
        format.json { render json: @projects_members_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects_members_months/1
  # DELETE /projects_members_months/1.json
  def destroy
    @projects_members_month.destroy
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def projects_members_month_params
      params.permit(:member_name, *months_values.map(&:to_sym))
    end

    def months
      @months ||= 12.times.map do |n|
        Time.local(2016,4).since(n.month)
      end
    end

    def months_values
      months.map{|m|m.strftime("%Y%m")}
    end

    def months_headers
      months.map{|m|m.strftime("%m月")}
    end

    def months_columns
      months_values.map do |m|
        {
          data: m,
          type: "numeric",
          format: "0.00"
        }
      end
    end

    def months_schema
      Hash[months_values.map{|m|[m,nil]}]
    end
end
