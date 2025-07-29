import React from 'react'

export default function MemberBorrowings({ borrowings }) {
  if (!borrowings || borrowings.length === 0) {
    return (
      <div>
        <h4>My Borrowings</h4>
        <p>You have no borrowed books.</p>
      </div>
    )
  }
  return (
    <div style={{ marginBottom: 16 }}>
      <h4>My Borrowings</h4>
      <ul>
        {borrowings.map(borrowing => (
          <li key={borrowing.id}>
            Book: <strong>{borrowing.book_title}</strong> 
            - Due at: {borrowing.due_at}
            {borrowing.overdue && (
              <span style={{ color: 'red', marginLeft: 10 }}>Overdue!</span>
            )}
          </li>
        ))}
      </ul>
    </div>
  )
}
