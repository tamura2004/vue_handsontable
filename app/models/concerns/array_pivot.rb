module ArrayPivot
  refine Array do

    def pivot(header)
      header.default = 0

      inject(header) do |memo,row|
        memo.tap do |memo|
          if row.cost
            # memo[:total] += row.cost
            memo[row.month] += row.cost
          end
        end
      end
    end

  end
end