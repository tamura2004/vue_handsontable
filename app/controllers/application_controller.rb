class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

    def months
      @months ||= 12.times.map do |n|
        Time.local(2016,8).since(n.month)
      end
    end

    def months_values
      months.map{|m|m.strftime("%Y%m")}
    end

    def months_symbols
      months_values.map(&:to_sym)
    end

  #   def months_headers
  #     months.map{|m|m.strftime("%m月")}
  #   end

  #   def months_columns
  #     months_values.map do |m|
  #       {
  #         data: m,
  #         type: "numeric",
  #         format: "0.00"
  #       }
  #     end
  #   end

  #   def months_immutable_columns
  #     months_values.map do |m|
  #       {
  #         disableVisualSelection: true,
  #         readOnly: true,
  #         data: m,
  #         type: "numeric",
  #         format: "0.00"
  #       }
  #     end
  #   end

  #   def months_pivot_sql
  #     months_values.map{|month|
  #       <<-"SQL"
  #         sum(case when month = '#{month}' then cost end) as "#{month}"
  #       SQL
  #     }.join(",")
  #   end

  #   def months_schema
  #     Hash[months_values.map{|m|[m,nil]}]
  #   end

end
