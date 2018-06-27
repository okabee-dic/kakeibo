class Store < ApplicationRecord
  has_many :genres
  belongs_to :receipts, optional: true
end
