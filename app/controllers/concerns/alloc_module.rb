module AllocModule
  extend ActiveSupport::Concern

  def update
    month = alloc_params.keys.try(:first)
    cost = alloc_params.values.try(:first)
    @alloc = ProjectsMembersMonth.find_by(projects_member: @assign, month: month)

    if @alloc
      if cost.to_f > 0
        if @alloc.update(cost: cost)
          render json: @alloc, status: :ok
        else
          render json: @alloc.errors.full_messages, status: :unprocessable_entity
        end
      else
        @alloc.destroy
        head :no_content
      end

    else
      @alloc = ProjectsMembersMonth.new(projects_member: @assign, month: month, cost: cost)
      if @alloc.save
        render json: @alloc, status: :ok
      else
        render json: @alloc.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  private
    def set_assign
      @assign = ProjectsMember.find(params[:id])
    end

    def alloc_params
      params.permit(*MonthTypes.keys.map(&:to_sym))
    end
end
