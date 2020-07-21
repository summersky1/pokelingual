require 'test_helper'

class PokemonTest < ActiveSupport::TestCase

  test "search using english name" do
    pokemon_list = Pokemon.search('pikachu', 1)
    assert_equal(pokemon_list[0].id, '25')
    assert_equal(pokemon_list[0].name_english, 'Pikachu')
  end

  test "search using japanese name" do
    pokemon_list = Pokemon.search('ピカチュウ', 1)
    assert_equal(pokemon_list[0].id, '25')
    assert_equal(pokemon_list[0].name_japanese, 'ピカチュウ')
  end

  test "search using romaji" do
    pokemon_list = Pokemon.search('rizadon', 1)
    assert_equal(pokemon_list[0].id, '6')
    assert_equal(pokemon_list[0].name_romaji, 'Rizādon')
  end

  test "search using name prefix" do
    pokemon_list = Pokemon.search('pika', 1)
    assert_equal(pokemon_list[0].id, '25')
  end

  test "search with slightly incorrect spelling" do
    pokemon_list = Pokemon.search('pikchu', 1)
    assert_equal(pokemon_list[0].id, '25')
  end

  test "search by pokemon types" do
    pokemon_list = Pokemon.search('water ice', 1)
    assert_equal(pokemon_list[0].types[0].english, 'Water')
    assert_equal(pokemon_list[0].types[1].japanese, 'こおり')
  end
end
