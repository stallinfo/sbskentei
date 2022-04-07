# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_07_010145) do

  create_table "dailyexcercises", force: :cascade do |t|
    t.datetime "daily"
    t.integer "kmondai_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["kmondai_id"], name: "index_dailyexcercises_on_kmondai_id"
    t.index ["user_id"], name: "index_dailyexcercises_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "domains", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fkaitos", force: :cascade do |t|
    t.integer "fukusu_id", null: false
    t.integer "user_id", null: false
    t.integer "kmondai_id", null: false
    t.integer "fmondai_id", null: false
    t.integer "answer"
    t.boolean "kettei"
    t.boolean "correct"
    t.string "answerstring"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fmondai_id"], name: "index_fkaitos_on_fmondai_id"
    t.index ["fukusu_id"], name: "index_fkaitos_on_fukusu_id"
    t.index ["kmondai_id"], name: "index_fkaitos_on_kmondai_id"
    t.index ["user_id"], name: "index_fkaitos_on_user_id"
  end

  create_table "fmondais", force: :cascade do |t|
    t.integer "fukusu_id", null: false
    t.integer "kmondai_id", null: false
    t.boolean "kettei"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fukusu_id"], name: "index_fmondais_on_fukusu_id"
    t.index ["kmondai_id"], name: "index_fmondais_on_kmondai_id"
  end

  create_table "fukusus", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "fname"
    t.integer "numofexam"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_fukusus_on_user_id"
  end

  create_table "fusers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "fukusu_id", null: false
    t.integer "result"
    t.boolean "testdone"
    t.float "resultfloat"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fukusu_id"], name: "index_fusers_on_fukusu_id"
    t.index ["user_id"], name: "index_fusers_on_user_id"
  end

  create_table "kchoices", force: :cascade do |t|
    t.integer "kmondai_id", null: false
    t.string "sentence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number"
    t.index ["kmondai_id"], name: "index_kchoices_on_kmondai_id"
  end

  create_table "kenteikaitous", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "datetest"
    t.string "answer"
    t.integer "kmondai_id", null: false
    t.boolean "correct"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["kmondai_id"], name: "index_kenteikaitous_on_kmondai_id"
    t.index ["user_id"], name: "index_kenteikaitous_on_user_id"
  end

  create_table "kmondais", force: :cascade do |t|
    t.integer "number"
    t.string "question"
    t.integer "level"
    t.string "answer"
    t.string "system"
    t.string "order"
    t.string "suborder"
    t.string "explanation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "oriquestion"
    t.boolean "demasu"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active", default: false
    t.string "name"
    t.string "asanaapi"
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dailyexcercises", "kmondais"
  add_foreign_key "dailyexcercises", "users"
  add_foreign_key "fkaitos", "fmondais"
  add_foreign_key "fkaitos", "fukusus"
  add_foreign_key "fkaitos", "kmondais"
  add_foreign_key "fkaitos", "users"
  add_foreign_key "fmondais", "fukusus"
  add_foreign_key "fmondais", "kmondais"
  add_foreign_key "fukusus", "users"
  add_foreign_key "fusers", "fukusus"
  add_foreign_key "fusers", "users"
  add_foreign_key "kchoices", "kmondais"
  add_foreign_key "kenteikaitous", "kmondais"
  add_foreign_key "kenteikaitous", "users"
end
