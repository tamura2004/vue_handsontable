class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :group, foreign_key: true
      t.string :number
      t.string :name
      t.float :cost # 承認原価
      t.float :rd # 要件定義工数

      t.timestamps
    end
  end
end
