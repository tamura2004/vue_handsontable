class Api::V1::ProjectsController < ActionController::API
    def index
      @projects = Project.view
  
      # 以下のような複合クエリを受け付ける
      # /projects?members=1,2&id=3,4
      #
      if params[:members]
        ids = params[:members].split(/,/)
        @projects = @projects.where(members: { id: ids })
      end
      
      if params[:id]
        ids = params[:id].split(/,/)
        @projects = @projects.where(id: ids )
      end
  
      render json: JSON.pretty_generate(@projects.as_json)
    end
  end
  