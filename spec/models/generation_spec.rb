require 'rails_helper'

RSpec.describe Generation, type: :model do
  fixtures :generations, :pokemons

  context "get Pokemon by generation" do
    it "finds Pokemon from generation 1" do
      pokemon = Generation.get_pokemon_from_generation(1).first
      expect(pokemon.name_english).to eq("Charmander")
      expect(pokemon.generation_id).to eq(1)
    end
  end

end
