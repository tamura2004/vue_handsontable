class WorksController < ApplicationController
  before_action :set_member, only: [:update]
  before_action :set_group, only: [:index,:update]

  # GET /works
  # GET /works.json
  def index
    @groups = Group.all

    gon.records =
      Member.where(group: @group).view.pivot

    gon.options = {
      colHeaders: [
        "職位",
        "社員番号",
        "氏名",
        *months_headers,
        "合計"
      ],
      columns: [
        {data: "jobs_name"},
        {data: "number"},
        {data: "name"},
        *months_columns,
        {data: "total", type: "numeric", format: "0.0"}
      ],
    }

  end

  # POST /works
  # POST /works.json
  def create
    head :no_content
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    month = work_params.keys.try(:first)
    cost = work_params.values.try(:first)

    @work = Work.find_by(member: @member, month: month)

    if @work
      if cost.to_f > 0
        if @work.update(cost: cost)
          render json: @work, status: :ok
        else
          render json: @work.errors.full_messages, status: :unprocessable_entity
        end
      else
        @work.destroy
        head :no_content
      end

    else
      @work = Work.new(member: @member, month: month, cost: cost)
      if @work.save
        render json: @work, status: :ok
      else
        render json: @work.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: 'Work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.permit(months_symbols)
    end
end
