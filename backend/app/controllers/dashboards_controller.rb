class DashboardsController < ApplicationController
  authorize_resource class: false

  def index
    @total_books = Book.accessible_by(current_ability).count
    @total_borrowed_books =  Borrowing.accessible_by(current_ability).active.count
    @books_due_today = Borrowing.accessible_by(current_ability).due_today
    @overdue_members = User.accessible_by(current_ability).overdue_members

    render :index
  end
end
