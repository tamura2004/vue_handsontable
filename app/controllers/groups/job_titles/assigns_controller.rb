class Groups::JobTitles::AssignsController < ApplicationController
  before_action :set_job_title, only: [:index]
  before_action :set_group, only: [:index]

  def index
    @data = {
      works: {
        records: VWork
          .select(:member_number,:member_link,:month,:cost)
          .select("member_id as id")
          .where(group_id: @group)
          .where(job_title_id: @job_title)
          .order(:member_number)
          .pivot,
        options: {
          colHeaders: [*%w(番号 担当名), *months_headers, "合計" ],
          columns: [
            {data: "member_number"},
            {data: "member_link",renderer:"html"},
            *months_columns,
            {data: "total", type: "numeric", format: "0.00"}
          ]
        }
      },
      members_projects_months: {
        records: Alloc
          .member_total_view
          .where(group_id: @group)
          .where(job_title_id: @job_title)
          .pivot,
        options: {
          colHeaders: [*%w(番号 担当名), *months_headers, "合計" ],
          columns: [
            {data: "member_number"},
            {data: "member_link",renderer:"html"},
            *months_columns,
            {data: "total", type: "numeric", format: "0.00"}
          ]
        }
      },
      projects_members_months: {
        records: Alloc.project_view
          .select("project_id as id")
          .where(job_title_id:@job_title)
          .pivot,
        options: {
          colHeaders: [*%w(案件管理番号 案件名), *months_headers, "合計" ],
          columns: [
            {data: "project_number"},
            {data: "project_link",renderer:"html"},
            *months_columns,
            {data: "total", type: "numeric", format: "0.00"}
          ]
        }
      }
    }

  end

  private
    def set_job_title
      @job_title = ::JobTitle.find(params[:job_title_id])
    end

    def set_group
      @group = Group.find(params[:group_id])
    end

end
