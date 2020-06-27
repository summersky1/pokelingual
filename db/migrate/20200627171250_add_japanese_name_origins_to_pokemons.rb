class AddJapaneseNameOriginsToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :name_origin_japanese, :text
    add_column :pokemons, :name_origin_japanese_for_english, :text
  end
end
