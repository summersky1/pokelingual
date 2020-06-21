class Pokemon < ApplicationRecord
  def self.get_random_pokemon(quantity)
    Pokemon.find(Pokemon.pluck(:id).sample(quantity))
  end
end
