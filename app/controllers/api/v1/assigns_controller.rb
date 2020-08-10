class Api::V1::AssignsController < ActionController::API
# class Api::V1::AssignsController < ApplicationController
  def index
    @assigns = Assign.view.order("projects.id,month")

    # 以下のような複合クエリを受け付ける
    # /assigns?members=1,2&projects=3,4
    #
    %i[members projects].each do |key|
      next unless params[key]
      ids = params[key].split(/,/)
      @assigns = @assigns.where(key => { id: ids })
    end

    render json: JSON.pretty_generate(@assigns.as_json)
  end
end
