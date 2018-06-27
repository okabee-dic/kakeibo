class Receiptlist < ApplicationRecord
    belongs_to :book
    belongs_to :receipt
end
