require 'csv'

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
    name_romaji: row[3]
  })
  pokemon.types << (Type.find_by_english(row[4]))
  pokemon.types << (Type.find_by_english(row[5])) if row[5].present?
end

puts "Finished seeding Pokemon data!"