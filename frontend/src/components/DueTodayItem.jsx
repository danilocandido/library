import React, { useState } from 'react'

export default function DueTodayItem({ borrowing, user, token }) {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [returned, setReturned] = useState(false)

  const handleReturn = async () => {
    setError('')
    setLoading(true)
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
            borrowing: {
              user_id: borrowing.user_id,
              book_id: borrowing.book_id
            }
          })
        }
      )
      if (!response.ok) throw new Error('Failed to mark as returned')
      setReturned(true)
    } catch {
      setError('Could not mark as returned')
    } finally {
      setLoading(false)
    }
  }

  return (
    <li>
      Book: <strong>{borrowing.book_title}</strong>
      - User: {borrowing.user_id} - Due at: {borrowing.due_at}
      {user.role === 'librarian' && !returned && (
        <button
          style={{ marginLeft: 10 }}
          onClick={handleReturn}
          disabled={loading}
        >
          {loading ? 'Returning...' : 'Return'}
        </button>
      )}
      {returned && (
        <span style={{ marginLeft: 10, color: 'green' }}>Returned!</span>
      )}
      {error && (
        <span style={{ marginLeft: 10, color: 'red' }}>{error}</span>
      )}
    </li>
  )
}
