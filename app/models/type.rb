class Type < ApplicationRecord
  has_many :pokemon_types
  has_many :pokemons, :through => :pokemon_types

  def self.find_by_english(type)
    Type.find_by(english: type)
  end
end
