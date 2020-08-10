class Api::V1::MembersController < ActionController::API
  def index
    @member = Member.all
    render json: JSON.pretty_generate(@member.as_json)
  end
end
