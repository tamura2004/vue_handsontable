class Groups::AllocsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @groups = Group.all
    @members = Member.with_allocs
      .where(group_id: @group)
      .decorate
    @opts = Htbl::MembersBuilder.htbl_options
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end

end
