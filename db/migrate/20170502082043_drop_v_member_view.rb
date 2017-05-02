class DropVMemberView < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      drop view v_members;
    SQL
  end
end
