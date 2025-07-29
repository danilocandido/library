import React from 'react'
import BooksDueToday from './BooksDueToday'
import MemberBorrowings from './MemberBorrowings'

export default function Dashboard({ dashboard, user, token }) {
  return (
    <div>
      <h2>Dashboard</h2>
      {user.role === 'librarian' && (
        <div style={{ marginBottom: 16 }}>
          <div>Total books: {dashboard.total_books}</div>
          <div>Total borrowed books: {dashboard.total_borrowed_books}</div>
        </div>
      )}
      {user.role === 'member' && (
        <MemberBorrowings borrowings={dashboard.borrowings} />
      )}
      <BooksDueToday
        books_due_today={dashboard.books_due_today}
        user={user}
        token={token}
      />
      {user.role === 'librarian' && (
        <div>
          <h4>Overdue members</h4>
          <ul>
            {dashboard.books_overdue && dashboard.books_overdue.length === 0 && (
              <li>No overdue members.</li>
            )}
            {dashboard.books_overdue && dashboard.books_overdue.map(user => (
              <li key={user.id}>{user.name}</li>
            ))}
          </ul>
        </div>
      )}
    </div>
  )
}
