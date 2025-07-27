class Book < ApplicationRecord
  has_many :borrowings
  has_many :borrowers, through: :borrowings

  validates :isbn, uniqueness: true, length: 10..13
  validates :total_copies, numericality: { greater_than: 0 }

  def self.search(search_terms = '')
    return [] if search_terms.blank?

    stripped_terms = search_terms&.gsub(',', '')&.squish

    where("concat_ws(' ', title, author, genre) ILIKE ?", "%#{stripped_terms}%")
  end
end
