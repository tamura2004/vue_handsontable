class WorksController < ApplicationController
  before_action :set_member, only: [:update]
  before_action :set_group, only: [:index]

  # GET /works
  def index
    # @groups = Group.all
    @admin_members = Member.where(group_id: @group).admin.with_works.decorate
    @sofia_members = Member.where(group_id: @group).sofia.with_works.decorate
    @bp_members = Member.where(group_id: @group).bp.with_works.decorate
    @htbl_options = Htbl::MembersBuilder.htbl_options
  end

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    def set_group
      @group = current_group
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.permit(MonthTypes.keys.map(&:to_sym))
    end
end
