class Api::V1::AssignsController < ActionController::API
  def index
    assigns = Assign.by_member
    render json: JSON.pretty_generate(assigns.as_json)
  end
end
