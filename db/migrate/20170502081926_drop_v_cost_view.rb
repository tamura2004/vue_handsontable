class DropVCostView < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      drop view v_costs;
    SQL
  end
end
