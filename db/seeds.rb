require 'csv'

filepath = 'lib/datasets/'

Generation.delete_all
generations = []
CSV.foreach(filepath + 'generations.csv', headers: true) do |row|
  generations << Generation.new({
    id: row[0],
    region_english: row[1],
    region_japanese: row[2],
  })
end
Generation.bulk_import(generations)

Type.delete_all
types = []
CSV.foreach(filepath + 'types.csv', headers: true) do |row|
  types << Type.new({
    id: row[0],
    english: row[1],
    japanese: row[2],
  })
end
Type.bulk_import(types)

Ability.delete_all
abilities = []
abilities_hash = {} # used to save database calls when creating PokemonAbility records
CSV.foreach(filepath + 'abilities.csv', headers: true) do |row|
  abilities << Ability.new({
    id: row[0],
    english: row[1],
    description_english: row[2],
    japanese: row[3],
    description_japanese: row[4],
  })
  abilities_hash[row[1]] = row[0]
end
Ability.bulk_import(abilities)

previous_id = 0
pokemon_name_origins = []
CSV.foreach(filepath + 'pokemon_name_origins_jp.csv') do |row|
  # ignore alternate pokemon forms etc.
  if row[0].to_i != previous_id
    pokemon_name_origins[row[0].to_i] = { japanese: row[3], japanese_for_english: row[4] }
    previous_id = previous_id + 1
  end
end

CSV.foreach(filepath + 'pokemon_name_origins_en.csv', headers: true) do |row|
  pokemon_name_origins[row[0].to_i].merge!(english: row[2])
end

PokemonAbility.delete_all
PokemonType.delete_all
Pokemon.delete_all
pokemon_list = []
pokemon_types = []
pokemon_abilities = []
CSV.foreach(filepath + 'pokemon.csv', headers: true) do |row|
  pokemon_list << Pokemon.new({
    id: row[0],
    name_english: row[1],
    name_japanese: row[2],
    name_romaji: row[3],
    generation_id: row[6],
    name_origin_japanese: pokemon_name_origins[row[0].to_i][:japanese],
    name_origin_japanese_for_english: pokemon_name_origins[row[0].to_i][:japanese_for_english],
    name_origin_english: pokemon_name_origins[row[0].to_i][:english],
    hp: row[13],
    attack: row[14],
    defence: row[15],
    special_attack: row[16],
    special_defence: row[17],
    speed: row[18]
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
  pokemon_abilities << PokemonAbility.new({
    pokemon_id: row[0],
    ability_id: abilities_hash[row[7]]
  })
  if row[8].present?
    pokemon_abilities << PokemonAbility.new({
      pokemon_id: row[0],
      ability_id: abilities_hash[row[8]]
    })
  end
end
Pokemon.bulk_import(pokemon_list)
PokemonType.bulk_import(pokemon_types)
PokemonAbility.bulk_import(pokemon_abilities)

puts "Finished seeding Pokemon data!"
