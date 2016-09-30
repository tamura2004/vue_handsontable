class Groups::AllocsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @allocs = HtblParamsFactory.new do |t|
      t.model = Alloc.where(group_id: @group)
        .order(:job_title_id, :member_number)
      t.id_field = :member_id
      t.fields = :member_number, :job_title_link, :member_link
    end

    @groups = Group.all
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

end
