class AddIndexMonthToAlloc < ActiveRecord::Migration[5.0]
  def change
    add_index :allocs, :month
  end
end
