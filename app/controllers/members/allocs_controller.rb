class Members::AllocsController < ApplicationController
  include AllocModule

  before_action :set_member, only: [:index,:update]
  before_action :set_assign, only: [:update]

  def index
    @header = HtblParamsFactory.new do |t|
      t.model = VWork.where(member_id: @member)
      t.id_field = :member_id
      t.fields = :job_title_link,:member_number,:member_link
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(member_id: @member).order(:project_number)
      t.id_field = :id
      t.fields = :project_number, :project_link
    end
  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end

end
