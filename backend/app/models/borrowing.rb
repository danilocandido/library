class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  before_validation :ensure_only_members_can_borrow, on: :create
  before_validation :ensure_borrow, on: :create

  validates :book_id, uniqueness: {
    scope: :user_id,
    conditions: -> { where(returned_at: nil) }
  }

  validate :user_cannot_borrow_same_book_twice, on: :create
  validate :book_must_have_available_copies, on: :create

  scope :active, -> { where(returned_at: nil) }
  scope :due_today, -> { where(due_at: Time.current.beginning_of_day..Time.current.end_of_day) }

  def return!
    update!(returned_at: Time.current)
  end

  private

  def ensure_only_members_can_borrow
    errors.add(:invalid) unless user.member?
  end

  def ensure_borrow
    self.borrowed_at = Time.current
    self.due_at = 14.days.from_now
  end

  def user_cannot_borrow_same_book_twice
    if user.borrowings.where(book: book).where(returned_at: nil).any?
      errors.add(:base, 'You have already borrowed this book')
    end
  end

  def book_must_have_available_copies
    errors.add(:base, 'Book is not available') if book.total_copies.zero?
  end
end
