require 'csv'

Generation.delete_all
generations = []
CSV.foreach('lib/datasets/generations.csv', headers: true) do |row|
  generations << Generation.new({
    id: row[0],
    region_english: row[1],
    region_japanese: row[2]
  })
end
Generation.bulk_import(generations)

Type.delete_all
types = []
CSV.foreach('lib/datasets/types.csv', headers: true) do |row|
  types << Type.new({
    id: row[0],
    english: row[1],
    japanese: row[2],
  })
end
Type.bulk_import(types)

PokemonType.delete_all
Pokemon.delete_all
pokemon_list = []
pokemon_types = []
CSV.foreach('lib/datasets/pokemon.csv', headers: true) do |row|
  pokemon_list << Pokemon.new({
    id: row[0],
    name_english: row[1],
    name_japanese: row[2],
    name_romaji: row[3],
    generation_id: row[6]
  })
  pokemon_types << PokemonType.new({
    pokemon_id: row[0],
    type_id: (Type.find_by_english(row[4]).id)
  })
  if row[5].present?
    pokemon_types << PokemonType.new({
      pokemon_id: row[0],
      type_id: (Type.find_by_english(row[5]).id)
    })
  end
end
Pokemon.bulk_import(pokemon_list)
PokemonType.bulk_import(pokemon_types)

previous_id = 0
CSV.foreach('lib/datasets/pokemon_name_origins_jp.csv') do |row|
  # ignore alternate pokemon forms etc.
  if row[0].to_i != previous_id
    pokemon = Pokemon.find(row[0])
    pokemon.update(name_origin_japanese: row[3], name_origin_japanese_for_english: row[4])
    previous_id = previous_id + 1
  end
end

CSV.foreach('lib/datasets/pokemon_name_origins_en.csv', headers: true) do |row|
  pokemon = Pokemon.find(row[0])
  pokemon.update(name_origin_english: row[2])
end

puts "Finished seeding Pokemon data!"
