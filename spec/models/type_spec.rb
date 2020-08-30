require 'rails_helper'

RSpec.describe Type, type: :model do
  fixtures :types

  context "find" do
    it "finds Type by English" do
      pokemon_type = Type.find_by_english("Fire")
      expect(pokemon_type.english).to eq("Fire")
    end
  end

end
