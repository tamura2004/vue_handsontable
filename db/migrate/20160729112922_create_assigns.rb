class CreateAssigns < ActiveRecord::Migration[5.0]
  def change
    create_table :assigns do |t|
      t.references :project, foreign_key: true
      t.references :member, foreign_key: true
      t.string :month
      t.integer :work

      t.timestamps
    end
  end
end
