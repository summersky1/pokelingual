class CreateAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :abilities do |t|
      t.string :english
      t.string :description_english
      t.string :japanese
      t.string :description_japanese
      t.timestamps
    end
  end
end
