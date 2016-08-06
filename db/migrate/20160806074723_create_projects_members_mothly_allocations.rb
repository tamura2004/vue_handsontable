class CreateProjectsMembersMothlyAllocations < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_members_mothly_allocations do |t|
      t.references :project, foreign_key: true
      t.references :member, foreign_key: true
      t.string :month
      t.float :cost

      t.timestamps
    end
  end
end
