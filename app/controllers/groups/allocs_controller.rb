class Groups::AllocsController < ApplicationController
  before_action :set_group, only: :index

  def index
    @members = Member.with_allocs
      .where(group_id: @group)
      .decorate
  end

  private

    def set_group
      @group = current_group
    end

end
