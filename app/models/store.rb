class Store < ApplicationRecord
  has_many :genres
  belongs_to :receipts, optional: true
  belongs_to :books, optional: true
end
