class AddStatsToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :hp, :integer
    add_column :pokemons, :attack, :integer
    add_column :pokemons, :defence, :integer
    add_column :pokemons, :special_attack, :integer
    add_column :pokemons, :special_defence, :integer
    add_column :pokemons, :speed, :integer
  end
end
