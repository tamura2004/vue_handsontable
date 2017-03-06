class HtblParamsFactory

  attr_writer :model,:id_field,:fields
  attr_accessor :title

  def initialize
    yield self if block_given?

    generate_rows
    generate_opts
  end

  def rows
    @rows.to_json
  end

  def opts
    @opts.to_json
  end

  private
  
    def generate_rows
      @rows = @model
        .select(*@fields,:month,:cost)
        .select("#{@id_field} as id")
        .pivot

      @rows.map! do |row|
        months_blanks.merge row
      end
    end

    def generate_opts
      @opts = {
        colHeaders: [
          *fields_headers,
          *months_headers,
          "合計"
        ],
        columns: [
          *fields_columns,
          *months_columns,
          {data: "total", type: "numeric", format:"0.00"}
        ]
      }

    end
  
    def fields_headers
      @fields.map do |field|
        @model.human_attribute_name(field)
      end
    end

    def fields_columns
      @fields.map do |field|
        if field =~ /_link$/
          {data: field, renderer: "html"}
        else
          {data: field}
        end
      end
    end

    def months
      @months ||= 12.times.map do |n|
        Time.local(2017,4).since(n.month)
      end
    end

    def months_values
      months.map{|m|m.strftime("%Y%m")}
    end

    def months_blanks
      months_values.inject({}) do |memo,m|
        memo.merge m => ""
      end
    end

    def months_headers
      months.map{|m|m.strftime("%m月")}
    end

    def months_columns
      months_values.map do |m|
        {
          data: m,
          type: "numeric",
          format: "0.00"
        }
      end
    end
end

