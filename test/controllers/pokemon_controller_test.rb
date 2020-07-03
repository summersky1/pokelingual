require 'test_helper'

class PokemonControllerTest < ActionDispatch::IntegrationTest
  def setup
    @pokemon = pokemons(:one)
    @generation = generations(:one)
    @type = types(:one)
  end

  test "should get home" do
    get pokemon_path
    assert_response :success
    assert_equal(@pokemon.types[0], @type)
  end

  test "should get show" do
    get pokemon_path + "/" + @pokemon.id.to_s
    assert_response :success
  end
end
