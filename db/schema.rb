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

ActiveRecord::Schema.define(version: 2020_08_21_153716) do

  create_table "abilities", force: :cascade do |t|
    t.string "english"
    t.string "description_english"
    t.string "japanese"
    t.string "description_japanese"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "generations", force: :cascade do |t|
    t.string "region_english"
    t.string "region_japanese"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pokemon_abilities", force: :cascade do |t|
    t.integer "pokemon_id"
    t.integer "ability_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ability_id"], name: "index_pokemon_abilities_on_ability_id"
    t.index ["pokemon_id", "ability_id"], name: "index_pokemon_abilities_on_pokemon_id_and_ability_id", unique: true
    t.index ["pokemon_id"], name: "index_pokemon_abilities_on_pokemon_id"
  end

  create_table "pokemon_types", force: :cascade do |t|
    t.integer "pokemon_id"
    t.integer "type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pokemon_id", "type_id"], name: "index_pokemon_types_on_pokemon_id_and_type_id", unique: true
    t.index ["pokemon_id"], name: "index_pokemon_types_on_pokemon_id"
    t.index ["type_id"], name: "index_pokemon_types_on_type_id"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "name_english"
    t.string "name_japanese"
    t.string "name_romaji"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "name_origin_japanese"
    t.text "name_origin_japanese_for_english"
    t.text "name_origin_english"
    t.integer "generation_id"
    t.integer "hp"
    t.integer "attack"
    t.integer "defence"
    t.integer "special_attack"
    t.integer "special_defence"
    t.integer "speed"
    t.index ["generation_id"], name: "index_pokemons_on_generation_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "english"
    t.string "japanese"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
