class CreateGenerations < ActiveRecord::Migration[6.0]
  def change
    create_table :generations do |t|
      t.string :region_english
      t.string :region_japanese
      t.timestamps
    end
  end
end
