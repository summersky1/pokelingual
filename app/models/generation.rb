class Generation < ApplicationRecord
  has_many :pokemons

  def self.get_pokemon_from_generation(generation, page)
    Generation.find(generation).pokemons.page(page).per(15)
  end
end
