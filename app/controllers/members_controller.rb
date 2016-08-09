class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    gon.records = Member.connection.select_all(<<-SQL).to_a
      select
        members.id as id,
        groups.name as group_name,
        job_titles.name as job_title_name,
        members.number as number,
        members.name as name
      from members
      left join groups on members.group_id = groups.id
      left join job_titles on members.job_title_id = job_titles.id
    SQL

    gon.options = {
      dataSchema: {id: nil, name: nil, group_name: nil, job_title_name: nil, number: nil},
      colHeaders: ["所属", "職位", "社員番号", "氏名"],
      columns: [
        {
          width: 180,
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

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
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
