class Genre < ApplicationRecord
  belongs_to :stores, optional: true
end
