# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    can :read, :dashboard
    can :search, Book
    can :read, Book
    can :manage, Book if user.librarian?


    if user.librarian?
      can :return, Borrowing
      can :read, Borrowing
      can :read, User
    end

    if user.member?
      can :create, Borrowing
      can :read, Borrowing, user_id: user.id
      can :read, User, id: user.id
    end
  end
end
