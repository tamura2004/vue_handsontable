class CreateProjectsMembersMonths < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_members_months do |t|
      t.references :projects_member, foreign_key: true
      t.string :month
      t.float :cost

      t.timestamps
    end
  end
end
