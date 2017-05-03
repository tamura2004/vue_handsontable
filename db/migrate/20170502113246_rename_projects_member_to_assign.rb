class RenameProjectsMemberToAssign < ActiveRecord::Migration[5.0]
  def change
    rename_table :projects_members, :assigns
  end
end
