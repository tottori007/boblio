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

ActiveRecord::Schema.define(version: 2022_03_17_085614) do

  create_table "game_options", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "name_jp"
    t.text "description_en"
    t.text "description_jp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_options_on_game_id"
  end

  create_table "games", primary_key: "game_id", force: :cascade do |t|
    t.string "name_en", null: false
    t.integer "release_year"
    t.integer "player_min"
    t.integer "player_max"
    t.string "player_best"
    t.integer "playing_time"
    t.integer "playing_time_min"
    t.integer "playing_time_max"
    t.integer "age_min"
    t.string "image_url"
    t.string "thumbnail_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_games_on_game_id"
    t.index ["name_en"], name: "index_games_on_name_en"
  end

end
