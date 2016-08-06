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

ActiveRecord::Schema.define(version: 20160806074723) do

  create_table "assigns", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "member_id"
    t.string   "month"
    t.integer  "work"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_assigns_on_member_id"
    t.index ["project_id"], name: "index_assigns_on_project_id"
  end

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
    t.index ["department_id"], name: "index_groups_on_department_id"
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
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["job_title_id"], name: "index_members_on_job_title_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "number"
    t.string   "name"
    t.float    "cost"
    t.float    "rd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_projects_on_group_id"
  end

  create_table "projects_members_mothly_allocations", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "member_id"
    t.string   "month"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_projects_members_mothly_allocations_on_member_id"
    t.index ["project_id"], name: "index_projects_members_mothly_allocations_on_project_id"
  end

  create_table "projects_monthly_allocations", force: :cascade do |t|
    t.integer  "project_id"
    t.string   "month"
    t.float    "cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projects_monthly_allocations_on_project_id"
  end

end
