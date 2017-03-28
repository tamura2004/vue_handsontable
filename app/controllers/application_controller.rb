class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

    def months
      @months ||= 12.times.map do |n|
        Time.local(2017,4).since(n.month)
      end
    end

    def months_values
      months.map{|m|m.strftime("%Y%m")}
    end

    def months_symbols
      months_values.map(&:to_sym)
    end

end
