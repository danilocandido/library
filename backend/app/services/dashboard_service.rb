class DashboardService
  def initialize(user)
    @user = user
  end

  def call
    if @user.librarian?
      librarian_dashboard
    else
      member_dashboard
    end
  end

  private

  def librarian_dashboard
    {
      total_books: Book.count,
      total_borrowed_books: Borrowing.active.count,
      books_due_today: Borrowing.due_today.as_json,
      overdue_members: overdue_members.as_json
    }
  end

  def member_dashboard
    borrowings = @user.borrowings
    {
      borrowed_books: borrowings.active.as_json,
      overdue_books: borrowings.overdue.as_json
    }
  end

  def overdue_members
    User.joins(:borrowings)
        .where("borrowings.due_at < ? AND borrowings.returned_at IS NULL", Time.current.end_of_day)
        .distinct
  end
end
