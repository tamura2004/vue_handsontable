class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @records = Member.connection.select_all(<<-SQL).to_a
      select
        members.id as id,
        groups.name as group_name,
        job_titles.name as job_title_name,
        members.number as number,
        members.name as name
      from members
      left join groups on members.group_id = groups.id
      left join job_titles on members.job_title_id = job_titles.id
      order by group_id, job_title_id, number, name
    SQL

    @options = {
      dataSchema: {id: nil, name: nil, group_name: nil, job_title_name: nil, number: nil},
      colHeaders: ["所属", "職位", "社員番号", "氏名"],
      columns: [
        {
          data: "group_name",
          type: "dropdown",
          source: Group.pluck(:name)
        },
        {
          data: "job_title_name",
          type: "dropdown",
          source: JobTitle.pluck(:name)
        },
        {data: "number"},
        {data: "name"}
      ],
      autoColumnSize: true,
      minSpareRows: 1,
      contextMenu: ["remove_row"]
    }

  end

  # GET /members/1.json
  def show
  end

  # POST /members.json
  def create
    @member = Member.new(member_params)
    if @member.save
      render json: @member, status: :created
    else
      render json: @member.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    if @member.update(member_params)
      render json: @member, status: :ok
    else
      render json: @member.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.permit(:name, :group_name, :job_title_name, :number)
    end
end
