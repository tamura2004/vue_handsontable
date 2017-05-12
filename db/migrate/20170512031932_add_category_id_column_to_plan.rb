class AddCategoryIdColumnToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :system_id, :integer
  end
end
