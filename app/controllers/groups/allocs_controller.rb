class Groups::AllocsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @allocs = HtblParamsFactory.new do |t|
      t.model = Alloc.where(group_id: @group).where("month > ?", "201703")
        .order(:job_title_id, :member_number)
      t.id_field = :member_id
      t.fields = :job_title_link, :member_number, :member_link
    end

    @groups = Group.all
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

end
