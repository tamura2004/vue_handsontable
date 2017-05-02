class DropVWorksView < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      drop view v_works;
    SQL
  end
end
