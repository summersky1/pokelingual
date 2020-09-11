class PokemonController < ApplicationController

  def search
    @search_success = false
    if params[:query].present?
      @pokemon_list = Pokemon.search(params[:query], params[:page])
      @search_success = true if !@pokemon_list.empty?
    end
    @pokemon_list = Pokemon.get_random_pokemon(9) if @search_success == false
    
    respond_to do |format|
      format.html
      format.js { render partial: 'layouts/javascript/get_results' }
    end
  end

  def autocomplete
    pokemon_list = []
    if params[:query].present?
      if contains_kana(params[:query])
        pokemon_list = Pokemon.autocomplete(to_katakana(params[:query]), true)
      elsif params[:query].length >= 2
        pokemon_list = Pokemon.autocomplete(params[:query], false)
      end
    end
    render json: pokemon_list
  end

  def show
    pokemon_id = params[:id].to_i
    @pokemon = Pokemon.find(pokemon_id)
    @prev_pokemon = Pokemon.get_previous_pokemon(pokemon_id)
    @next_pokemon = Pokemon.get_next_pokemon(pokemon_id)
    @normalized_stats = Pokemon.get_normalized_pokemon_stats(@pokemon)
  end

  def generation
    @pokemon_list = Generation.get_pokemon_from_generation(params[:id])
    @first_pokemon_id = @pokemon_list[0].id
    @last_pokemon_id = @pokemon_list[-1].id
    @pokemon_list = @pokemon_list.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js { render partial: 'layouts/javascript/get_generation' }
    end
  end

  def about
  end

  private
    def contains_kana(string)
      string =~ /\p{Katakana}|\p{Hiragana}/
    end

    # convert hiragana to katakana (only for autocomplete suggestions)
    def to_katakana(query)
      query.tr('ぁ-ん','ァ-ン')
    end
end
