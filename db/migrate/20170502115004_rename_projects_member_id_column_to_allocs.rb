class RenameProjectsMemberIdColumnToAllocs < ActiveRecord::Migration[5.0]
  def change
    rename_column :allocs, :projects_member_id, :assign_id
  end
end
