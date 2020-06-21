class CreateTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :types do |t|
      t.string :english
      t.string :japanese
      t.timestamps
    end
  end
end
