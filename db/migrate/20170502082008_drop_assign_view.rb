class DropAssignView < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      drop view assigns;
    SQL
  end
end
