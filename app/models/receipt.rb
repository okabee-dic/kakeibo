class Receipt < ApplicationRecord
  has_many :receiptlists, dependent: :destroy
  has_many :receipt_books, through: :receiptlists, source: :book
  has_many :stores
  
  validates :price, presence: true
end
