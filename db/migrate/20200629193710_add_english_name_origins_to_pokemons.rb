class AddEnglishNameOriginsToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :name_origin_english, :text
  end
end
