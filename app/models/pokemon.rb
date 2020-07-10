class Pokemon < ApplicationRecord
  has_many :pokemon_types
  has_many :types, :through => :pokemon_types
  belongs_to :generation

  def self.get_random_pokemon(quantity)
    Pokemon.find(Pokemon.pluck(:id).sample(quantity))
  end

  def self.get_previous_pokemon(pokemon_id)
    if pokemon_id > 1
      pokemon_id = pokemon_id - 1
    else
      pokemon_id = Pokemon.count
    end
    Pokemon.find(pokemon_id)
  end

  def self.get_next_pokemon(pokemon_id)
    if pokemon_id < Pokemon.count
      pokemon_id = pokemon_id + 1
    else
      pokemon_id = 1
    end
    Pokemon.find(pokemon_id)
  end
end
