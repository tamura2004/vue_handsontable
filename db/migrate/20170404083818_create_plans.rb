class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.string :category
      t.string :main_group_name
      t.string :project_number
      t.string :project_name
      t.string :accuracy
      t.string :dept_name
      t.string :group_name
      t.string :sub_number
      t.string :system_name
      t.string :contract_type
      t.string :company_name
      t.string :member_rank
      t.integer :unit_price
      t.float :manhour_last_month_landing
      t.float :manhour_performance
      t.float :manhour_development_plan
      t.float :manhour_landing
      t.float :manhour_divergence
      t.float :manhour_ernings
      t.float :money_last_month_landing
      t.float :money_performance
      t.float :money_development_plan
      t.float :money_landing
      t.float :money_divergence
      t.float :money_ernings
      t.float :cost_rate_plan
      t.float :cost_rate_landing
      t.float :gross_profit_plan
      t.float :gross_profit_landing
      t.float :gross_profit_divergence
      t.string :to_be_confirmed
      t.float :m1
      t.float :m2
      t.float :m3
      t.float :m4
      t.float :m5
      t.float :m6
      t.float :m7
      t.float :m8
      t.float :m9
      t.float :m10
      t.float :m11
      t.float :m12

      t.timestamps
    end
  end
end
