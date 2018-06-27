class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.integer :store_id
      t.date :pay_date
      t.integer :price, null: false
      t.integer :genre_id
      
      t.timestamps
    end
  end
end
