class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.references :group, foreign_key: true
      t.references :job_title, foreign_key: true
      t.string :number

      t.timestamps
    end
  end
end
