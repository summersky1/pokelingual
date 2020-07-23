class Generation < ApplicationRecord
  has_many :pokemons

  def self.get_pokemon_from_generation(generation)
    Generation.find(generation).pokemons.order(:id)
  end
end
