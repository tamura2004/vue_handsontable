class DropVProjectView < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      drop view v_project;
    SQL
  end
end
