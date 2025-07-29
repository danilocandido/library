json.dashboard do

  if current_user.librarian?
    json.total_books @total_books
    json.total_borrowed_books @total_borrowed_books
  end
  
  json.books_due_today @books_due_today do |borrowing|
    json.id borrowing.id
    json.user_id borrowing.user_id
    json.book_id borrowing.book_id
    json.book_title borrowing.book.title
    json.due_at borrowing.due_at.strftime('%Y-%m-%d')
  end

  if current_user.member?
    json.borrowings current_user.borrowings do |borrowing|
      json.id borrowing.id
      json.book_id borrowing.book_id
      json.book_title borrowing.book.title
      json.due_at borrowing.due_at.strftime('%Y-%m-%d')
      json.overdue borrowing.due_at.present? && borrowing.due_at < Time.current
    end
  end

  json.books_overdue @overdue_members do |user|
    json.id user.id
    json.name user.email
  end
end
