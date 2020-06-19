class PokemonController < ApplicationController
  def home
    @pokemon_list = Pokemon.first(20)
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
