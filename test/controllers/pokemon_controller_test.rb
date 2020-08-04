require 'test_helper'

class PokemonControllerTest < ActionDispatch::IntegrationTest
  def setup
    @pokemon = pokemons(:one)
    @generation = generations(:one)
    @type = types(:one)
  end

  test "should get search" do
    get '/en/search'
    assert_response :success
  end

  test "should get show" do
    get "/en/pokemon/#{@pokemon.id}"
    assert_response :success
  end

  test "should get autocomplete" do
    get "/en/autocomplete"
    assert_response :success
  end

  test "should load japanese locale" do
    get '/ja/search'
    assert_response :success
  end

  test "should redirect without locale" do
    get '/search'
    assert_response :redirect
  end

  test "should redirect incorrect location" do
    get '/en/search/hello'
    assert_response :redirect
  end

  test "pokemon type is correct" do
    assert_equal(@pokemon.types[0], @type)
  end

  test "pokemon generation is correct" do
    assert_equal(@pokemon.generation, @generation)
  end
end
