class RenameProjectsMembersMonthToAlloc < ActiveRecord::Migration[5.0]
  def change
    rename_table :projects_members_months, :allocs
  end
end
