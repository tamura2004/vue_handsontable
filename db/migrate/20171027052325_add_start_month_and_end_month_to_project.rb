class AddStartMonthAndEndMonthToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :start_month, :string
    add_column :projects, :end_month, :string
  end
end
