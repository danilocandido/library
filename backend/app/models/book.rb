class Book < ApplicationRecord
  validates :isbn, length: 10..13 
  validates :total_copies, numericality: { greater_than: 0 }

  def self.search(search_terms = '')
    return [] if search_terms.blank?

    stripped_terms = search_terms&.gsub(',', '')&.squish

    where("concat_ws(' ', title, author, genre) ILIKE ?", "%#{stripped_terms}%")
  end
end
