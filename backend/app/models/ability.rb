# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    can :search, Book
    can :manage, Book if user.librarian?

    can :return, Borrowing if user.librarian?
    can :create, Borrowing if user.member?
  end
end
