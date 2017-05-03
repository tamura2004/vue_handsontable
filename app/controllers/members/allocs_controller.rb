class Members::AllocsController < ApplicationController
  include AllocModule

  before_action :set_member, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    # 割当のまだない案件も表示する
    # @assigns = @member.assigns
    # @works = @member.works
  end

  private
    def set_member
      @member = Member.find(params[:member_id]).decorate
    end

end
