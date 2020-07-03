class AddGenerationToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_reference :pokemons, :generation
  end
end
