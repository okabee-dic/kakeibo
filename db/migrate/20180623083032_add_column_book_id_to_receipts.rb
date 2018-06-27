class AddColumnBookIdToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :book_id, :integer
  end
end
