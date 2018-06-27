class Book < ApplicationRecord
  has_many :receiptlists, dependent: :destroy
  belongs_to :user, optional: true
  has_many :monthlyinputs, dependent: :destroy
  has_many :receipts, through: :receiptlists, source: :receipt
end
