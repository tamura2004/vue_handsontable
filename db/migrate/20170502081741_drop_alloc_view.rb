class DropAllocView < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      drop view allocs;
    SQL
  end
end
