class MembersMonthsController < ApplicationController
  before_action :set_members_month, only: [:show, :edit, :update, :destroy]

  # GET /members_months
  # GET /members_months.json
  def ags
    gon.records = ProjectsMembersMonth.joins(:job_title).where(job_titles: {name: "AGS"}).member_view.pivot.map do |row|
      row.tap do |row|
        if row.has_key? "name"
          row["name"] = view_context.link_to row["name"], view_context.member_members_projects_months_path(row["id"])
        end
      end
    end

    gon.options = {
      colHeaders: [
        "所属",
        "職位",
        "社員番号",
        "氏名",
        *months_headers
      ],
      columns: [
        {
          data: "group",
          readOnly: true,
          renderer: "html"
        },
        {
          data: "job",
          readOnly: true,
          renderer: "html"
        },
        {
          data: "number",
          readOnly: true
        },
        {
          data: "name",
          readOnly: true,
          renderer: "html"
        },
        *months_immutable_columns
      ],
    }
  end

  def index
    gon.records = ProjectsMembersMonth.member_view.pivot.map do |row|
      row.tap do |row|
        if row.has_key? "name"
          row["name"] = view_context.link_to row["name"], view_context.member_members_projects_months_path(row["id"])
        end
      end
    end

    gon.options = {
      colHeaders: [
        "所属",
        "職位",
        "社員番号",
        "氏名",
        *months_headers
      ],
      columns: [
        {
          data: "group",
          readOnly: true,
          renderer: "html"
        },
        {
          data: "job",
          readOnly: true,
          renderer: "html"
        },
        {
          data: "number",
          readOnly: true
        },
        {
          data: "name",
          readOnly: true,
          renderer: "html"
        },
        *months_immutable_columns
      ],
    }
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
        format.json { render json: @members_month.errors.full_messages, status: :unprocessable_entity }
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
        format.json { render json: @members_month.errors.full_messages, status: :unprocessable_entity }
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

end
