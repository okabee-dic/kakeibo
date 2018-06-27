class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres do |t|
      t.string :name, null: false
      t.integer :convinience, default: 0
      t.integer :eatout, default: 0
      t.integer :supermarket, default: 0
      t.integer :income, default: 0
      t.integer :hobby, default: 0
      t.integer :cost, default: 0
      t.timestamps
    end
  end
end
