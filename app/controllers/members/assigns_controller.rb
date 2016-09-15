class Members::AssignsController < ApplicationController
  before_action :set_member, only: :index

  def index
    @h_member = HtblParamsFactory.new do |t|
      t.model = VMember.where(id: @member)
      t.fields = :job_title_link,:member_number,:member_link
      t.pivot = false
    end

    @assigns = HtblParamsFactory.new do |t|
      t.model = Assign.where(member_id: @member)
      t.id_field = :project_id
      t.fields = :project_number, :project_link
    end
  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end
end
