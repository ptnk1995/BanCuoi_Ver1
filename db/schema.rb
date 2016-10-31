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

ActiveRecord::Schema.define(version: 20161023173731) do

  create_table "activities", force: :cascade do |t|
    t.integer  "action_type"
    t.integer  "target_type"
    t.integer  "target_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "answer_chooses", force: :cascade do |t|
    t.boolean  "is_correct"
    t.integer  "question_exam_id"
    t.integer  "answer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["answer_id"], name: "index_answer_chooses_on_answer_id"
    t.index ["question_exam_id"], name: "index_answer_chooses_on_question_exam_id"
  end

  create_table "answers", force: :cascade do |t|
    t.string   "content"
    t.boolean  "is_correct"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exams", force: :cascade do |t|
    t.integer  "status"
    t.integer  "mark"
    t.datetime "started_at"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_exams_on_category_id"
    t.index ["user_id", "created_at"], name: "index_exams_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "question_exams", force: :cascade do |t|
    t.boolean  "is_correct"
    t.integer  "question_id"
    t.integer  "exam_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["exam_id"], name: "index_question_exams_on_exam_id"
    t.index ["question_id"], name: "index_question_exams_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "pattern"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "suggest_answers", force: :cascade do |t|
    t.text     "content"
    t.boolean  "is_correct"
    t.integer  "suggest_question_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["suggest_question_id"], name: "index_suggest_answers_on_suggest_question_id"
  end

  create_table "suggest_questions", force: :cascade do |t|
    t.text     "content"
    t.boolean  "status"
    t.integer  "pattern"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_suggest_questions_on_category_id"
    t.index ["user_id", "created_at"], name: "index_suggest_questions_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_suggest_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.integer  "role",            default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
