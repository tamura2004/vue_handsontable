class Api::V1::Members::AllocsController < ActionController::API
  def index
    member = Member.find(params[:member_id]).decorate

    options = Chart::StackedAreaDirector.build(member)
    rows = Htbl::ProjectsBuilder.allocs(member.assigns)
    opts = Htbl::ProjectsBuilder.htbl_options

    data = {
      options: options,
      rows: rows,
      opts: opts
    }

    render json: JSON.pretty_generate(data.as_json)
  end
end
