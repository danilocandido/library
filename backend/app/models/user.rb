class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, { member: 0, librarian: 1 }

  scope :overdue_members, -> do
    joins(:borrowings)
      .where("borrowings.due_at < ? AND borrowings.returned_at IS NULL", Time.current.end_of_day).distinct
  end

  has_many :borrowings
  has_many :borrowers, through: :borrowings
end
