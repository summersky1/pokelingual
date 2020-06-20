require 'test_helper'

class PokemonControllerTest < ActionDispatch::IntegrationTest
  def setup
    @pokemon = pokemons(:one)
  end

  test "should get home" do
    get pokemon_path
    assert_response :success
  end

  test "should get show" do
    get pokemon_path + "/" + @pokemon.id.to_s
    assert_response :success
  end
end
