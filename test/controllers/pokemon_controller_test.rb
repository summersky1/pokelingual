require 'test_helper'

class PokemonControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get "/pokemon"
    assert_response :success
  end

  test "should get show" do
    get "/pokemon/", params: {id: 1}
    assert_response :success
  end

end
