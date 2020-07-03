require 'csv'

Generation.delete_all
CSV.foreach('lib/datasets/generations.csv', headers: true) do |row|
  Generation.create({
    id: row[0],
    region_english: row[1],
    region_japanese: row[2]
  })
end

Type.delete_all
CSV.foreach('lib/datasets/types.csv', headers: true) do |row|
  Type.create({
    id: row[0],
    english: row[1],
    japanese: row[2],
  })
end

PokemonType.delete_all

Pokemon.delete_all
CSV.foreach('lib/datasets/pokemon.csv', headers: true) do |row|
  pokemon = Pokemon.create({
    id: row[0],
    name_english: row[1],
    name_japanese: row[2],
    name_romaji: row[3],
    generation_id: row[6]
  })
  pokemon.types << (Type.find_by_english(row[4]))
  pokemon.types << (Type.find_by_english(row[5])) if row[5].present?
end

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
