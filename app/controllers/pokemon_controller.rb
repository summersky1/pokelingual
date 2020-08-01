class PokemonController < ApplicationController
  around_action :switch_locale

  def search
    @search_success = false
    if params[:query].present?
      @pokemon_list = Pokemon.search(params[:query], params[:page])
      @search_success = true if !@pokemon_list.empty?
    end
    @pokemon_list = Pokemon.get_random_pokemon(9) if @search_success == false
  end

  def autocomplete
    if params[:query].present? && params[:query].length >= 2
      pokemon_list = Pokemon.autocomplete(params[:query])
      # '_source' is the indexed model data from the Elasticsearch response
      pokemon_list = pokemon_list.map(&:_source)
      # combine English and Japanese names into single array for combined autocomplete suggestions
      english_names = pokemon_list.map(&:name_english)
      japanese_names = pokemon_list.map(&:name_japanese)
      pokemon_list = english_names + japanese_names
      render json: pokemon_list
    else
      render json: []
    end
  end

  def show
    pokemon_id = params[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    @prev_pokemon = Pokemon.get_previous_pokemon(pokemon_id)
    @next_pokemon = Pokemon.get_next_pokemon(pokemon_id)
  end

  def generation
    @pokemon_list = Generation.get_pokemon_from_generation(params[:id])
    @first_pokemon_id = @pokemon_list[0].id
    @last_pokemon_id = @pokemon_list[-1].id
    @pokemon_list = @pokemon_list.page(params[:page]).per(12)
  end

  private
    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
end
