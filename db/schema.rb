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

ActiveRecord::Schema.define(version: 20160830142928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer  "department_id"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_groups_on_department_id", using: :btree
  end

  create_table "job_titles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.integer  "group_id"
    t.integer  "job_title_id"
    t.string   "number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["group_id"], name: "index_members_on_group_id", using: :btree
    t.index ["job_title_id"], name: "index_members_on_job_title_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "number"
    t.string   "name"
    t.float    "cost"
    t.float    "rd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_projects_on_group_id", using: :btree
  end

  create_table "projects_members", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_projects_members_on_member_id", using: :btree
    t.index ["project_id"], name: "index_projects_members_on_project_id", using: :btree
  end

  create_table "projects_members_months", force: :cascade do |t|
    t.integer  "projects_member_id"
    t.string   "month"
    t.float    "cost"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["projects_member_id"], name: "index_projects_members_months_on_projects_member_id", using: :btree
  end

  create_table "projects_monthly_allocations", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "month"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projects_monthly_allocations_on_project_id", using: :btree
  end

  create_table "works", force: :cascade do |t|
    t.integer  "member_id"
    t.string   "month"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_works_on_member_id", using: :btree
  end

  add_foreign_key "groups", "departments"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "job_titles"
  add_foreign_key "projects", "groups"
  add_foreign_key "projects_members", "members"
  add_foreign_key "projects_members", "projects"
  add_foreign_key "projects_members_months", "projects_members"
  add_foreign_key "projects_monthly_allocations", "projects"
  add_foreign_key "works", "members"
end
