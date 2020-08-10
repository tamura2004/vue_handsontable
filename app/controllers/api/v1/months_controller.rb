class Api::V1::MonthsController < ActionController::API
  def index
    render json: JSON.pretty_generate(MonthTypes.keys.as_json)
  end
end
