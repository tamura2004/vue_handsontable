class ResultsController < ApplicationController

  ATTRIBUTES = %w(month group_number group_name outsource_code company_name member_number member_name project_number project_name proc_number proc_name cont_number cont_name system_number cost cost_minute)
  LABELS = %w(稼働年月 部署コード 部署名 外注区分 会社名 社員番号 社員名 案件番号 案件名 工程コード 工程名称 契約種別コード 契約種別名称 システムナンバー 工数 工数分)
  HEADERS = ATTRIBUTES.inject({}){|memo,a| memo.merge a.to_sym => a}

  def index
    respond_to do |format|
      format.html do
        @records = Result.all
        @options = {
          colHeaders: %w(月 社員番号 社員名 案件番号 案件名 工数),
          columns: %w(month member_number member_name project_number project_name cost).map{|a|{data: a}},
          columnSorting: true,
          contextMenu: ["remove_row"]
        }
      end

      format.xlsx do
        @attributes = ATTRIBUTES
        timestamp = Time.zone.now.strftime("%Y%m%d%H%M%S")
        filename = "results_#{timestamp}.xlsx"
        response.headers['Content-Disposition'] = "attachment; filename=#{filename}"
      end
    end
  end

  def destroy
    Result.find(params[:id]).destroy
    head :no_content
  end

  def upload
    file = params[:file].path.to_s
    xlsx = Roo::Excelx.new(file)

    Result.transaction do
      xlsx.sheet(0).each(HEADERS) do |param|
        Result.create(param)
      end
    end
    redirect_to :results

    rescue => e
    render json: e.message
  end

end
