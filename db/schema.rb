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

ActiveRecord::Schema.define(version: 20170716174041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "build_statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "builds", primary_key: "build_id", force: :cascade do |t|
    t.integer "build_number"
    t.bigint "suite_type_id"
    t.bigint "project_id"
    t.bigint "build_status_id"
    t.datetime "run_at"
    t.integer "seed"
    t.integer "duration_milliseconds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["build_status_id"], name: "index_builds_on_build_status_id"
    t.index ["project_id"], name: "index_builds_on_project_id"
    t.index ["suite_type_id"], name: "index_builds_on_suite_type_id"
  end

  create_table "projects", primary_key: "project_id", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suite_types", primary_key: "suite_type_id", force: :cascade do |t|
    t.string "suite_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_case_results", force: :cascade do |t|
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_cases", primary_key: "test_case_id", force: :cascade do |t|
    t.bigint "build_id"
    t.bigint "test_id"
    t.bigint "test_case_result_id"
    t.integer "duration_microseconds"
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["build_id"], name: "index_test_cases_on_build_id"
    t.index ["test_case_result_id"], name: "index_test_cases_on_test_case_result_id"
    t.index ["test_id"], name: "index_test_cases_on_test_id"
  end

  create_table "tests", primary_key: "test_id", force: :cascade do |t|
    t.string "class_name"
    t.string "test_name"
    t.string "file_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
