class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :group
      t.string :job
      t.string :number

      t.timestamps
    end
  end
end
