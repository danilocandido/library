class Book < ApplicationRecord
  validates :isbn, length: 10..13 
  validates :total_copies, numericality: { greater_than: 0 }
end
