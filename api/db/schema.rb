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

ActiveRecord::Schema.define(version: 2019_06_27_173053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.json "bodies", null: false
    t.boolean "confirming", null: false
    t.uuid "problem_id", null: false
    t.uuid "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id", "team_id", "created_at"], name: "index_answers_on_problem_id_and_team_id_and_created_at", unique: true
    t.index ["problem_id"], name: "index_answers_on_problem_id"
    t.index ["team_id"], name: "index_answers_on_team_id"
  end

  create_table "attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "filename", null: false
    t.string "description", null: false
    t.string "token", null: false
    t.binary "data", null: false
    t.uuid "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_attachments_on_team_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", null: false
    t.string "title", null: false
    t.string "description", limit: 8192, null: false
    t.integer "order", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_categories_on_code", unique: true
  end

  create_table "configs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "value", limit: 8192, null: false
    t.integer "value_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_configs_on_key", unique: true
  end

  create_table "first_correct_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "answer_id", null: false
    t.uuid "problem_id", null: false
    t.uuid "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_first_correct_answers_on_answer_id"
    t.index ["problem_id"], name: "index_first_correct_answers_on_problem_id"
    t.index ["team_id", "problem_id"], name: "index_first_correct_answers_on_team_id_and_problem_id", unique: true
    t.index ["team_id"], name: "index_first_correct_answers_on_team_id"
  end

  create_table "issue_comments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "text", limit: 8192, null: false
    t.boolean "from_staff", null: false
    t.uuid "issue_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_issue_comments_on_issue_id"
  end

  create_table "issues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.integer "status", null: false
    t.uuid "problem_id", null: false
    t.uuid "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_issues_on_problem_id"
    t.index ["team_id"], name: "index_issues_on_team_id"
  end

  create_table "notices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.string "text", limit: 8192, null: false
    t.boolean "pinned", null: false
    t.uuid "target_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_team_id"], name: "index_notices_on_target_team_id"
  end

  create_table "problem_bodies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "mode", null: false
    t.string "title", null: false
    t.integer "perfect_point", null: false
    t.string "text", limit: 8192, null: false
    t.json "candidates"
    t.json "corrects"
    t.uuid "problem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_problem_bodies_on_problem_id"
  end

  create_table "problem_environments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "status", null: false
    t.string "host", null: false
    t.string "user", null: false
    t.string "password", null: false
    t.uuid "problem_id", null: false
    t.uuid "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_problem_environments_on_problem_id"
    t.index ["team_id"], name: "index_problem_environments_on_team_id"
  end

  create_table "problem_supplements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "text", limit: 8192, null: false
    t.uuid "problem_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["problem_id"], name: "index_problem_supplements_on_problem_id"
  end

  create_table "problems", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", null: false
    t.string "writer"
    t.string "secret_text", limit: 8192, null: false
    t.integer "order", null: false
    t.boolean "team_isolate", null: false
    t.tsrange "open_at"
    t.uuid "previous_problem_id"
    t.uuid "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_problems_on_category_id"
    t.index ["code"], name: "index_problems_on_code", unique: true
    t.index ["previous_problem_id"], name: "index_problems_on_previous_problem_id"
  end

  create_table "scores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "point"
    t.boolean "solved", null: false
    t.uuid "answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_scores_on_answer_id", unique: true
  end

  create_table "teams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "role", null: false
    t.integer "number", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "organization"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
    t.index ["number"], name: "index_teams_on_number", unique: true
  end

end
