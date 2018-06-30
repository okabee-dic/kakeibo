class Genre < ApplicationRecord
  belongs_to :stores, optional: true
  
  validates :name, presence: true
end
