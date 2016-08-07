class CreateMembersMonths < ActiveRecord::Migration[5.0]
  def change
    create_table :members_months do |t|
      t.references :member, foreign_key: true
      t.string :month
      t.float :cost

      t.timestamps
    end
  end
end
