require 'elasticsearch/model'

class Pokemon < ApplicationRecord
  belongs_to :generation
  has_many :pokemon_types
  has_many :types, :through => :pokemon_types
  has_many :pokemon_abilities
  has_many :abilities, :through => :pokemon_abilities

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :name_english, :name_japanese, :name_romaji],
      include: {
        types: {
          only: [:id, :english, :japanese]
        },
        abilities: {
          only: [:english, :japanese]
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
                fields: ['types.english^2', 'types.japanese^2', 'abilities.english', 'abilities.japanese']
              }
            }
          ]
        }
      }
    }).page(page).per(9)
  end

  def self.autocomplete(query, contains_kana)
    language = contains_kana ? "name_japanese" : "name_english"
    pokemon_list = __elasticsearch__.search({
      query: {
        match_phrase_prefix: {
          language => query
        }
      }
    }).limit(5)
    format_autocomplete_suggestions(pokemon_list, contains_kana)
  end

  def self.format_autocomplete_suggestions(pokemon_list, contains_kana)
    # '_source' is the indexed model data from the Elasticsearch response
    pokemon_list = pokemon_list.map(&:_source)
    autocomplete_suggestions = []
    pokemon_list.each do |pokemon|
      location = "/#{I18n.locale}/pokemon/#{pokemon.id}"
      pokemon_name = contains_kana ? pokemon.name_japanese : pokemon.name_english
      autocomplete_suggestions << { name: pokemon_name, url: location }
    end
    autocomplete_suggestions
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

  # normalize stat using the maximum value in that column as a value out of 100
  # really high values are capped to give a better bar chart representation
  def self.get_normalized_pokemon_stats(pokemon)
    normalized_stats = {}
    normalized_stats["hp"] = (pokemon.hp.to_f / 200 * 100).round
    normalized_stats["attack"] = (pokemon.attack.to_f / 181 * 100).round
    normalized_stats["defence"] = (pokemon.defence.to_f / 200 * 100).round
    normalized_stats["special_attack"] = (pokemon.special_attack.to_f / 173 * 100).round
    normalized_stats["special_defence"] = (pokemon.special_defence.to_f / 200 * 100).round
    normalized_stats["speed"] = (pokemon.speed.to_f / 160 * 100).round
    normalized_stats
  end
end
