class Members::AssignsController < ApplicationController
  before_action :set_member, only: [:index]

  def index
    gon.push({
      member: {
        records: [[
          @member.group.try(:name),
          @member.job_title.try(:name),
          @member.number,
          @member.name
        ]],
        options: {
          colHeaders: %w(グループ 職位 社員番号 氏名)
        }
      },

      members_projects_months: {
        records: Assign.project_view
          .select(:id)
          .where(member_id: @member.id)
          .pivot,
        options: {
          colHeaders: ["管理番号", "案件名", *months_headers ],
          columns: [
            {data: "project_number"},
            {data: "project_link",renderer:"html"},
            *months_columns
          ]
        }
      }
    })

  end

  private
    def set_member
      @member = Member.find(params[:member_id])
    end

end
