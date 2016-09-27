module ArrayPivot
  refine Array do
    def pivot(header)
      header.default = 0
      inject(header) do |memo,row|
        memo.tap do |memo|
          memo[row.month] += row.cost if row.cost && row.month
        end
      end
    end
  end
end