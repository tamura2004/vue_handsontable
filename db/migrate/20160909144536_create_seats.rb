class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.string :job
      t.string :name
      t.references :state, foreign_key: true
      t.integer :col
      t.integer :row

      t.timestamps
    end
  end
end
