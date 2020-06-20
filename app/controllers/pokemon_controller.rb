class PokemonController < ApplicationController
  def home
    @pokemon_list = Pokemon.find(Pokemon.pluck(:id).sample(9))
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
