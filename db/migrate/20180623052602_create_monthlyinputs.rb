class CreateMonthlyinputs < ActiveRecord::Migration[5.1]
  def change
    create_table :monthlyinputs do |t|
      t.integer :book_id, null: false
      t.date :start
      t.date :enddate
      t.integer :store_id, null: false
      t.integer :price, null: false
      t.timestamps
    end
  end
end
