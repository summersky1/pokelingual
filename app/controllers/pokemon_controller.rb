class PokemonController < ApplicationController
  around_action :switch_locale
 
  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def home
    @pokemon_list = Pokemon.get_random_pokemon(9)
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def generation
    @pokemon_list = Pokemon.where(generation_id: params[:id]).limit(9)
  end
end
