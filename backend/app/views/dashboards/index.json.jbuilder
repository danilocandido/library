json.dashboard do

  if current_user.librarian?
    json.total_books @total_books
    json.total_borrowed_books @total_borrowed_books
  end
  
  json.books_due_today @books_due_today do |borrowing|
    json.id borrowing.id
    json.book_title borrowing.book.title
    json.due_at borrowing.due_at.strftime('%Y-%m-%d')
  end

  json.books_overdue @overdue_members do |user|
    json.id user.id
    json.name user.email
  end
end
