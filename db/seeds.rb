require 'csv'

Type.delete_all
CSV.foreach('lib/datasets/types.csv', headers: true) do |row|
  Type.create({
    id: row[0],
    english: row[1],
    japanese: row[2],
  })
end

Pokemon.delete_all
CSV.foreach('lib/datasets/pokemon.csv', headers: true) do |row|
  Pokemon.create({
    id: row[0],
    name_english: row[1],
    name_japanese: row[2],
    name_romaji: row[3]
  })
end

puts "Finished seeding Pokemon data!"