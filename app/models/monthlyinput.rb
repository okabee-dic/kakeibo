class Monthlyinput < ApplicationRecord
  belongs_to :books, optional: true
  
  validates :inputday, numericality: { only_integer: true, less_than_or_equal_to: 31, greater_than_or_equal_to: 1 } 
  validates :price, presence: true
end
