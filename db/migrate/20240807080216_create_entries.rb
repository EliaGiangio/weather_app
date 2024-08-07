class CreateEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :entries do |t|
      t.string :city
      t.string :weather
      t.text :description
      t.integer :temp

      t.timestamps
    end
  end
end
