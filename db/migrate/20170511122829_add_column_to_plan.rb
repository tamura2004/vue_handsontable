class AddColumnToPlan < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :project_id, :integer
    add_column :plans, :month, :string
    add_column :plans, :cost, :float
  end
end
