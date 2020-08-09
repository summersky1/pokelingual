class CreatePokemonAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon_abilities do |t|
      t.belongs_to :pokemon
      t.belongs_to :ability
      t.timestamps
    end

    add_index :pokemon_abilities, [:pokemon_id, :ability_id], unique: true
  end
end
