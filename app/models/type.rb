class Type < ApplicationRecord
  has_and_belongs_to_many :pokemons

  def self.find_by_english(type)
    Type.find_by(english: type)
  end
end
