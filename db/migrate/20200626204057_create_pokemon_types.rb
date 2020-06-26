class CreatePokemonTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon_types do |t|
      t.belongs_to :pokemon
      t.belongs_to :type
      t.timestamps
    end

    add_index :pokemon_types, [:pokemon_id, :type_id], unique: true
  end
end
