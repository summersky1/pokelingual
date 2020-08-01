require 'elasticsearch/model'

class Pokemon < ApplicationRecord
  has_many :pokemon_types
  has_many :types, :through => :pokemon_types
  belongs_to :generation

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :name_english, :name_japanese, :name_romaji],
      include: {
        types: {
          only: [:id, :english, :japanese]
        }
      }
    )
  end

  def self.search(query, page)
    __elasticsearch__.search({
      query: {
        bool: {
          should: [
            {
              multi_match: {
                query: query,
                fields: [:name_english, :name_japanese, :name_romaji],
                type: :phrase_prefix
              }
            },
            {
              multi_match: {
                query: query,
                fields: [:name_english, :name_japanese, :name_romaji],
                fuzziness: :auto
              }
            },
            {
              multi_match: {
                query: query,
                fields: ['types.english', 'types.japanese']
              }
            }
          ]
        }
      }
    }).page(page).per(9)
  end

  def self.autocomplete(query)
    __elasticsearch__.search({
      query: {
        multi_match: {
          query: query,
          fields: [:name_english, :name_japanese],
          type: :phrase_prefix
        }
      }
    }).limit(5)
  end

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
