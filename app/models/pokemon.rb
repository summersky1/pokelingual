class Pokemon < ApplicationRecord
  has_many :pokemon_types
  has_many :types, :through => :pokemon_types
  belongs_to :generation

  def self.get_random_pokemon(quantity)
    Pokemon.find(Pokemon.pluck(:id).sample(quantity))
  end
end
