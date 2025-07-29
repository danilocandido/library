import React, { useState } from 'react'

export default function BookItem({ book, userId, token, userRole, onEdit }) {
  const [borrowed, setBorrowed] = useState(false)
  const [error, setError] = useState('')

  const handleBorrow = async () => {
    setError('')
    try {
      const response = await fetch('http://localhost:3000/api/borrowings', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ borrowing: { user_id: userId, book_id: book.id } })
      })
      if (!response.ok) throw new Error('Failed to borrow book')
      setBorrowed(true)
    } catch (err) {
      setError('Could not borrow the book')
    }
  }

  return (
    <li>
      <strong>{book.title}</strong> by {book.author}
      <span style={{ marginLeft: 10 }}>(Total copies: {book.total_copies})</span>
      {userRole === 'member' && book.overdue && (
        <span style={{ marginLeft: 10, color: 'red', fontWeight: 'bold' }}>
          Overdue!
        </span>
      )}
      {userId && userRole === 'member' && !borrowed && !book.already_borrowed && (
        <button style={{ marginLeft: 10 }} onClick={handleBorrow}>
          Borrow
        </button>
      )}
      {userRole === 'librarian' && onEdit && (
        <button style={{ marginLeft: 10 }} onClick={onEdit}>
          Edit
        </button>
      )}
      {borrowed && (
        <span style={{ marginLeft: 10, color: 'green' }}>Borrowed!</span>
      )}
      {error && (
        <span style={{ marginLeft: 10, color: 'red' }}>{error}</span>
      )}
    </li>
  )
}