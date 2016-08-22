class CreateWorks < ActiveRecord::Migration[5.0]
  def change
    create_table :works do |t|
      t.references :member, foreign_key: true
      t.string :month
      t.float :cost

      t.timestamps
    end
  end
end
