class Pokemon < ApplicationRecord
  has_and_belongs_to_many :types

  def self.get_random_pokemon(quantity)
    Pokemon.find(Pokemon.pluck(:id).sample(quantity))
  end
end
