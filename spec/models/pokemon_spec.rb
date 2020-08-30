require 'rails_helper'

RSpec.describe Pokemon, type: :model do

  context "search" do
    context "in English" do
      it "finds Pikachu" do
        pokemon = Pokemon.search('pikachu', 1).first
        expect(pokemon.id).to eq('25')
        expect(pokemon.name_english).to eq('Pikachu')
      end

      context "by name prefix" do
        it "finds Pikachu" do
          pokemon = Pokemon.search('pika', 1).first
          expect(pokemon.name_english).to eq("Pikachu")
        end
      end

      context "with incorrect spelling" do
        it "finds Pikachu" do
          pokemon = Pokemon.search('pikchu', 1).first
          expect(pokemon.name_english).to eq("Pikachu")
        end
      end

      context "by type" do
        it "finds Water Pokemon" do
          pokemon = Pokemon.search('water', 1).first
          expect(pokemon.types[0].english).to eq("Water")
        end

        it "finds Water and Ice Pokemon" do
          pokemon = Pokemon.search('water ice', 1).first
          expect(pokemon.types[0].english).to eq("Water")
          expect(pokemon.types[1].english).to eq("Ice")
        end
      end

      context "by ability" do
        it "finds Pokemon with 'Cute Charm'" do
          pokemon = Pokemon.search('cute charm', 1).first
          expect(pokemon.abilities[0].english).to eq("Cute Charm")
        end
      end
    end

    context "in Japanese" do
      it "finds ピカチュウ" do
        pokemon = Pokemon.search('ピカチュウ', 1).first
        expect(pokemon.id).to eq('25')
        expect(pokemon.name_japanese).to eq('ピカチュウ')
      end

      context "by name prefix" do
        it "finds ピカチュウ" do
          pokemon = Pokemon.search('ピカ', 1).first
          expect(pokemon.name_japanese).to eq("ピカチュウ")
        end
      end

      context "with incorrect spelling" do
        it "finds ピカチュウ" do
          pokemon = Pokemon.search('ピカチウ', 1).first
          expect(pokemon.name_japanese).to eq("ピカチュウ")
        end
      end

      context "by type" do
        it "finds みず Pokemon" do
          pokemon = Pokemon.search('みず', 1).first
          expect(pokemon.types[0].japanese).to eq("みず")
        end

        it "finds みず and こおり Pokemon" do
          pokemon = Pokemon.search('みず こおり', 1).first
          expect(pokemon.types[0].japanese).to eq("みず")
          expect(pokemon.types[1].japanese).to eq("こおり")
        end
      end

      context "by ability" do
        it "finds Pokemon with「メロメロボディ」" do
          pokemon = Pokemon.search('メロメロボディ', 1).first
          expect(pokemon.abilities[0].japanese).to eq("メロメロボディ")
        end
      end
    end

    context "using Romaji" do
      it "finds Zenigame" do
        pokemon = Pokemon.search('zenigame', 1).first
        expect(pokemon.id).to eq('7')
        expect(pokemon.name_romaji).to eq('Zenigame')
      end
    end
  end

  context "autocomplete" do
    context "in English" do
      it "contains two suggestions for 'pik'" do
        pokemon_list = Pokemon.autocomplete('pik', false)
        assert(pokemon_list.length == 2)
      end
    end

    context "in Japanese" do
      it "contains five suggestions for 'ピ'" do
        pokemon_list = Pokemon.autocomplete('ピ', true)
        assert(pokemon_list.length == 5)
      end
    end
  end

end
