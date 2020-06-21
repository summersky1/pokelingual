class CreatePokemonsTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons_types, id: false do |t|
      t.belongs_to :pokemon
      t.belongs_to :type
    end
  end
end
