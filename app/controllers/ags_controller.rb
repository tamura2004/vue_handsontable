class AgsController < ApplicationController


  def index

    options = {
      colHeaders:[
        "name",
        *months_headers,
        "total"
      ],
      columns: [
        {data:"name"},
        *months_columns,
        {data:"total", type:"numeric", format: "0.0"}
      ]
    }

    @variables = {}
    @project_keys = []
    @projects = []

    Project.find_each do |project|
      if project.members.any?{|m|m.job_title.try(:name) == "AGS"}
        @projects.push project

        key = "p#{project.id}"
        @project_keys.push key

        records = ProjectsMembersMonth.ags_view.where("projects.number = ?", project.number).pivot

        @variables.merge!({
          key => {
            records: records,
            options: options
          }
        })
      end
    end

    @variables.merge!({
      "total" => {
        records: ProjectsMembersMonth.ags_total_view.pivot,
        options: options
      }
    })


    @variables[:project_keys] = @project_keys
    gon.push @variables

  end
end
