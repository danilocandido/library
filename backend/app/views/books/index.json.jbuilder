json.array! @books do |book|
  json.extract!(
    book, :id, :title, :author, :genre, :isbn, :total_copies
  )
  json.already_borrowed current_user.borrowings.pluck(:book_id).include?(book.id)
  overdue = false
  if current_user.member?
    borrowing = current_user.borrowings.find_by(book_id: book.id)
    overdue = borrowing.present? && borrowing.due_at.present? && borrowing.due_at < Time.current
  end
  json.overdue overdue
end
