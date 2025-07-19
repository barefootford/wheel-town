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

ActiveRecord::Schema[8.0].define(version: 2025_07_19_182755) do
  create_table "recordings", force: :cascade do |t|
    t.date "date"
    t.string "gps_coordinates"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "title"
    t.string "recorder_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "time_start"
    t.time "time_end"
  end

  create_table "trips", force: :cascade do |t|
    t.string "vehicle"
    t.string "clothing"
    t.string "gender_of_clothing"
    t.integer "passenger_count"
    t.boolean "wearing_helmet"
    t.integer "recording_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recording_id"], name: "index_trips_on_recording_id"
  end

  add_foreign_key "trips", "recordings"
end
