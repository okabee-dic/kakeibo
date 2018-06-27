class CreateReceiptlists < ActiveRecord::Migration[5.1]
  def change
    create_table :receiptlists do |t|
      t.integer :receipt_id
      t.integer :book_id
      t.timestamps
    end
  end
end
