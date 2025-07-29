import React, { useState } from 'react'

export default function BooksDueToday({ books_due_today, user, token, onReturn }) {
  const [returningId, setReturningId] = useState(null)
  const [error, setError] = useState('')
  const [returnedId, setReturnedId] = useState(null)

  const handleReturn = async (borrowingId, userId, bookId) => {
    setError('')
    setReturningId(borrowingId)
    try {
      const response = await fetch(
        `http://localhost:3000/api/borrowings/return`,
        {
          method: 'PATCH',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`
          },
          body: JSON.stringify({
            borrowing: { user_id: userId, book_id: bookId }
          })
        }
      )
      if (!response.ok) throw new Error('Failed to mark as returned')
      setReturnedId(borrowingId)
      if (onReturn) onReturn()
    } catch {
      setError('Could not mark as returned')
    } finally {
      setReturningId(null)
    }
  }

  return (
    <div style={{ marginBottom: 16 }}>
      <h4>Books due today</h4>
      <ul>
        {books_due_today && books_due_today.length === 0 && (
          <li>No books due today.</li>
        )}
        {books_due_today && books_due_today.map(borrowing => (
          <li key={borrowing.id}>
            Book: <strong>{borrowing.book_title}</strong>
            - User: {borrowing.user_id} - Due at: {borrowing.due_at}
            {user.role === 'librarian' && (
              <>
                <button
                  style={{ marginLeft: 10 }}
                  onClick={() => handleReturn(borrowing.id, borrowing.user_id, borrowing.book_id)}
                  disabled={returningId === borrowing.id}
                >
                  {returningId === borrowing.id ? 'Returning...' : 'Return'}
                </button>
                {returnedId === borrowing.id && (
                  <span style={{ marginLeft: 10, color: 'green' }}>Returned!</span>
                )}
              </>
            )}
          </li>
        ))}
      </ul>
      {error && <p style={{ color: 'red' }}>{error}</p>}
    </div>
  )
}
