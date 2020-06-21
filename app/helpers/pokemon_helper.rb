module PokemonHelper
  def pokemon_large_image_url(pokemon_id)
    formatted_id = pokemon_id.to_s.rjust(3, '0')
    url = "https://assets.pokemon.com/assets/cms2/img/pokedex/full/#{formatted_id}.png"
  end

  def pokemon_thumbnail_image_url(pokemon_id)
    formatted_id = pokemon_id.to_s.rjust(3, '0')
    url = "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/#{formatted_id}.png"
  end

  def type_image_url(type_id)
    url = "/assets/type_#{type_id}.svg"
  end
end
