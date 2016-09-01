class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.string :month
      t.string :group_number
      t.string :group_name
      t.string :outsource_code
      t.string :company_name
      t.string :member_number
      t.string :member_name
      t.string :project_number
      t.string :project_name
      t.string :proc_number
      t.string :proc_name
      t.string :cont_number
      t.string :cont_name
      t.string :system_number
      t.float :cost
      t.string :cost_minute

      t.timestamps
    end
  end
end
