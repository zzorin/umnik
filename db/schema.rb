# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_27_081418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contests", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "starts_on"
    t.datetime "ends_on"
  end

  create_table "criterions", force: :cascade do |t|
    t.string "title"
    t.bigint "contest_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contest_id"], name: "index_criterions_on_contest_id"
  end

  create_table "experts", force: :cascade do |t|
    t.string "surname"
    t.string "name"
    t.string "patronymic"
    t.bigint "contest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: true
    t.index ["contest_id"], name: "index_experts_on_contest_id"
  end

  create_table "marks", force: :cascade do |t|
    t.integer "grade"
    t.bigint "criterion_id"
    t.bigint "expert_id"
    t.bigint "participant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["criterion_id"], name: "index_marks_on_criterion_id"
    t.index ["expert_id"], name: "index_marks_on_expert_id"
    t.index ["participant_id"], name: "index_marks_on_participant_id"
  end

  create_table "nominations", force: :cascade do |t|
    t.string "title"
    t.bigint "contest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.index ["contest_id"], name: "index_nominations_on_contest_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "surname"
    t.string "name"
    t.string "patronymic"
    t.string "project_title"
    t.text "project_info"
    t.string "organization"
    t.string "contact_info"
    t.bigint "nomination_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nomination_id"], name: "index_participants_on_nomination_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "user_id"
    t.string "role"
    t.string "context_type"
    t.bigint "context_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["context_type", "context_id"], name: "index_permissions_on_context_type_and_context_id"
    t.index ["user_id", "role", "context_id", "context_type"], name: "by_user_and_role_and_context"
  end

  add_foreign_key "criterions", "contests"
  add_foreign_key "experts", "contests"
  add_foreign_key "marks", "criterions"
  add_foreign_key "marks", "experts"
  add_foreign_key "marks", "participants"
  add_foreign_key "nominations", "contests"
  add_foreign_key "participants", "nominations"
end
