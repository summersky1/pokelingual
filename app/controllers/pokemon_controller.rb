class PokemonController < ApplicationController
  around_action :switch_locale
 
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def search
    @pokemon_list = Pokemon.get_random_pokemon(9)
  end

  def show
    pokemon_id = params[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    @prev_pokemon = Pokemon.get_previous_pokemon(pokemon_id)
    @next_pokemon = Pokemon.get_next_pokemon(pokemon_id)
  end

  def generation
    @pokemon_list = Generation.get_pokemon_from_generation(params[:id], params[:page])
  end
end
