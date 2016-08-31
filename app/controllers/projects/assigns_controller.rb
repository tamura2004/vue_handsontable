class Projects::AssignsController < ApplicationController
  before_action :set_project, only: [:index]

  def index
    gon.push({
      project: {
        records: [[
          @project.number,
          @project.name
        ]],
        options: {
          colHeaders: %w(案件管理番号 案件名)
        }
      },

      projects_members_months: {
        records: Assign.member_view
          .select(:id)
          .where(project_id: @project.id)
          .pivot,
        options: {
          colHeaders: [*%w(グループ 職位 社員番号 氏名), *months_headers ],
          columns: [
            {data: "group_name"},
            {data: "job_title_link", renderer: "html"},
            {data: "member_number"},
            {data: "member_link",renderer:"html"},
            *months_columns
          ]
        }
      }
    })

  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end

end
