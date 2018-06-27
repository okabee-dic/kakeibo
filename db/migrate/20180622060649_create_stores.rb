class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.integer :genre_id
      t.timestamps
    end
  end
end
