class CreateProjectsMonthlyAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_monthly_allocations do |t|
      t.references :project, foreign_key: true
      t.string :month
      t.float :cost

      t.timestamps
    end
  end
end
