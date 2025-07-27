class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, { member: 0, librarian: 1 }

  has_many :borrowings
  has_many :borrowers, through: :borrowings
end
