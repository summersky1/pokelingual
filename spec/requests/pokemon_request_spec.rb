require 'rails_helper'

RSpec.describe "Pokemon", type: :request do
  fixtures :pokemons, :generations

  it "should get search" do
    get '/en/search'
    expect(response).to be_successful
  end

  it "should get show" do
    charmander = pokemons(:charmander)
    get "/en/pokemon/#{charmander.id}"
    expect(response).to be_successful
  end

  it "should get generation" do
    gen1 = generations(:gen1)
    get "/en/generation/#{gen1.id}"
    expect(response).to be_successful
  end

  it "should get autocomplete" do
    get '/en/autocomplete'
    expect(response).to be_successful
    expect(response.content_type).to eq("application/json; charset=utf-8")
  end

  it "should load Japanese locale" do
    get '/ja/search'
    expect(response).to be_successful
  end

  it "should redirect no locale to :en" do
    get '/search'
    expect(response).to redirect_to('/en/search')
  end
  
  it "should redirect invalid location to root" do
    get '/en/search/hello'
    expect(response).to redirect_to('/')
  end

end
