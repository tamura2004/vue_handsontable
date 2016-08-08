class MembersMonthsController < ApplicationController
  before_action :set_members_month, only: [:show, :edit, :update, :destroy]

  # GET /members_months
  # GET /members_months.json
  def index
    # @members_months = MembersMonth.all
    results = []
    Member.order(:group_id, :job_title_id, :number).each do |member|
      result = Hash.new(0)
      result["id"] = member.id
      result["group_name"] = member.group.try(:name)
      result["job_title_name"] = member.job_title.try(:name)
      result["number"] = member.number
      result["name"] = "<a href='/members/#{member.id}/members_projects_months'>#{member.name}</a>"

      member.projects_members.each do |assignment|
        assignment.projects_members_months.each do |allocation|
          result[allocation.month] += allocation.cost.to_f
        end
      end
      results << result
    end
    gon.records = results

    gon.options = {
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
          width: 150,
          data: "group_name",
          disableVisualSelection: true,
          readOnly: true,
          renderer: "html"
        },
        {
          data: "job_title_name",
          disableVisualSelection: true,
          readOnly: true,
          renderer: "html"
        },
        {
          data: "number",
          disableVisualSelection: true,
          readOnly: true
        },
        {
          data: "name",
          disableVisualSelection: true,
          readOnly: true,
          renderer: "html"
        },
        *months_columns
      ],
    }
  end

  # GET /members_months/1
  # GET /members_months/1.json
  def show
  end

  # GET /members_months/new
  def new
    @members_month = MembersMonth.new
  end

  # GET /members_months/1/edit
  def edit
  end

  # POST /members_months
  # POST /members_months.json
  def create
    @members_month = MembersMonth.new(members_month_params)

    respond_to do |format|
      if @members_month.save
        format.html { redirect_to @members_month, notice: 'Members month was successfully created.' }
        format.json { render :show, status: :created, location: @members_month }
      else
        format.html { render :new }
        format.json { render json: @members_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members_months/1
  # PATCH/PUT /members_months/1.json
  def update
    respond_to do |format|
      if @members_month.update(members_month_params)
        format.html { redirect_to @members_month, notice: 'Members month was successfully updated.' }
        format.json { render :show, status: :ok, location: @members_month }
      else
        format.html { render :edit }
        format.json { render json: @members_month.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members_months/1
  # DELETE /members_months/1.json
  def destroy
    @members_month.destroy
    respond_to do |format|
      format.html { redirect_to members_months_url, notice: 'Members month was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_members_month
      @members_month = MembersMonth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def members_month_params
      params.require(:members_month).permit(:member_id, :month, :cost)
    end

    def months_columns
      months.map do |m|
        {
          data: m,
          disableVisualSelection: true,
          readOnly: true
        }
      end
    end

end
