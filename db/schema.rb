# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171027052325) do

  create_table "allocs", force: :cascade do |t|
    t.integer "assign_id"
    t.string "month"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assign_id"], name: "index_allocs_on_assign_id"
    t.index ["month"], name: "index_allocs_on_month"
  end

  create_table "assigns", force: :cascade do |t|
    t.integer "project_id"
    t.integer "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_assigns_on_member_id"
    t.index ["project_id"], name: "index_assigns_on_project_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "department_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_groups_on_department_id"
  end

  create_table "job_titles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.integer "group_id"
    t.integer "job_title_id"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["job_title_id"], name: "index_members_on_job_title_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "category"
    t.string "main_group_name"
    t.string "project_number"
    t.string "project_name"
    t.string "accuracy"
    t.string "dept_name"
    t.string "group_name"
    t.string "sub_number"
    t.string "system_name"
    t.string "contract_type"
    t.string "company_name"
    t.string "member_rank"
    t.integer "unit_price"
    t.float "manhour_last_month_landing"
    t.float "manhour_performance"
    t.float "manhour_development_plan"
    t.float "manhour_landing"
    t.float "manhour_divergence"
    t.float "manhour_ernings"
    t.float "money_last_month_landing"
    t.float "money_performance"
    t.float "money_development_plan"
    t.float "money_landing"
    t.float "money_divergence"
    t.float "money_ernings"
    t.float "cost_rate_plan"
    t.float "cost_rate_landing"
    t.float "gross_profit_plan"
    t.float "gross_profit_landing"
    t.float "gross_profit_divergence"
    t.string "to_be_confirmed"
    t.float "m1"
    t.float "m2"
    t.float "m3"
    t.float "m4"
    t.float "m5"
    t.float "m6"
    t.float "m7"
    t.float "m8"
    t.float "m9"
    t.float "m10"
    t.float "m11"
    t.float "m12"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "project_id"
    t.string "month"
    t.float "cost"
    t.integer "system_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer "group_id"
    t.string "number"
    t.string "name"
    t.float "cost"
    t.float "rd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.string "start_month"
    t.string "end_month"
    t.index ["group_id"], name: "index_projects_on_group_id"
  end

  create_table "projects_monthly_allocations", force: :cascade do |t|
    t.integer "project_id"
    t.string "month"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projects_monthly_allocations_on_project_id"
  end

  create_table "results", force: :cascade do |t|
    t.string "month"
    t.string "group_number"
    t.string "group_name"
    t.string "outsource_code"
    t.string "company_name"
    t.string "member_number"
    t.string "member_name"
    t.string "project_number"
    t.string "project_name"
    t.string "proc_number"
    t.string "proc_name"
    t.string "cont_number"
    t.string "cont_name"
    t.string "system_number"
    t.float "cost"
    t.string "cost_minute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systems", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.integer "member_id"
    t.string "month"
    t.float "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_works_on_member_id"
  end

end
