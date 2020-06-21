class PokemonController < ApplicationController
  def home
    @pokemon_list = Pokemon.get_random_pokemon(9)
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
