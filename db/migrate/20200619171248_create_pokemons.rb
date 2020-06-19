class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name_english
      t.string :name_japanese
      t.string :name_romaji
      t.timestamps
    end
  end
end
