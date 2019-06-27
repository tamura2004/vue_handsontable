# == Schema Information
#
# Table name: plans
#
#  id                         :integer          not null, primary key
#  category                   :string
#  main_group_name            :string
#  project_number             :string
#  project_name               :string
#  accuracy                   :string
#  dept_name                  :string
#  group_name                 :string
#  sub_number                 :string
#  system_name                :string
#  contract_type              :string
#  company_name               :string
#  member_rank                :string
#  unit_price                 :integer
#  manhour_last_month_landing :float
#  manhour_performance        :float
#  manhour_development_plan   :float
#  manhour_landing            :float
#  manhour_divergence         :float
#  manhour_ernings            :float
#  money_last_month_landing   :float
#  money_performance          :float
#  money_development_plan     :float
#  money_landing              :float
#  money_divergence           :float
#  money_ernings              :float
#  cost_rate_plan             :float
#  cost_rate_landing          :float
#  gross_profit_plan          :float
#  gross_profit_landing       :float
#  gross_profit_divergence    :float
#  to_be_confirmed            :string
#  m1                         :float
#  m2                         :float
#  m3                         :float
#  m4                         :float
#  m5                         :float
#  m6                         :float
#  m7                         :float
#  m8                         :float
#  m9                         :float
#  m10                        :float
#  m11                        :float
#  m12                        :float
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

FactoryBot.define do
  factory :plan do
    category                   { "MyString" }
    main_group_name            { "MyString" }
    project_number             { "MyString" }
    project_name               { "MyString" }
    accuracy                   { "MyString" }
    dept_name                  { "MyString" }
    group_name                 { "MyString" }
    sub_number                 { "MyString" }
    system_name                { "MyString" }
    contract_type              { "MyString" }
    company_name               { "MyString" }
    member_rank                { "MyString" }
    unit_price                 { 10 }
    manhour_last_month_landing { 0.5 }
    manhour_performance        { 0.5 }
    manhour_development_plan   { 0.5 }
    manhour_landing            { 0.5 }
    manhour_divergence         { 0.5 }
    manhour_ernings            { 0.5 }
    money_last_month_landing   { 0.5 }
    money_performance          { 0.5 }
    money_development_plan     { 0.5 }
    money_landing              { 0.5 }
    money_divergence           { 0.5 }
    money_ernings              { 0.5 }
    cost_rate_plan             { 0.5 }
    cost_rate_landing          { 0.5 }
    gross_profit_plan          { 0.5 }
    gross_profit_landing       { 0.5 }
    gross_profit_divergence    { 0.5 }
    to_be_confirmed            { "MyString" }
    m1                         { 0.5 }
    m2                         { 0.5 }
    m3                         { 0.5 }
    m4                         { 0.5 }
    m5                         { 0.5 }
    m6                         { 0.5 }
    m7                         { 0.5 }
    m8                         { 0.5 }
    m9                         { 0.5 }
    m10                        { 0.5 }
    m11                        { 0.5 }
    m12                        { 0.5 }
  end
end
