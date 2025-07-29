import React, { useState } from 'react'

export default function BookForm({ token, onSave, book, onCancel }) {
  const isEdit = !!book
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)
    const form = e.target

    const payload = {
      title: form.title.value,
      author: form.author.value,
      genre: form.genre.value,
      isbn: form.isbn.value,
      total_copies: form.total_copies.value
    }

    try {
      const url = isEdit
        ? `http://localhost:3000/api/books/${book.id}`
        : 'http://localhost:3000/api/books'
      const method = isEdit ? 'PUT' : 'POST'
      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ book: payload })
      })
      if (!response.ok) throw new Error('Failed to save book')
      const data = await response.json()
      onSave(data)
    } catch {
      setError('Could not save the book')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form
      onSubmit={handleSubmit}
      style={{ marginBottom: 20, border: '1px solid #ccc', padding: 16 }}
    >
      <h3>{isEdit ? 'Edit Book' : 'Add Book'}</h3>
      <input
        name="title"
        defaultValue={book ? book.title : ''}
        placeholder="Title"
        required
      />
      <input
        name="author"
        defaultValue={book ? book.author : ''}
        placeholder="Author"
        required
        style={{ marginLeft: 8 }}
      />
      <input
        name="genre"
        defaultValue={book ? book.genre : ''}
        placeholder="Genre"
        required
        style={{ marginLeft: 8 }}
      />
      <input
        name="isbn"
        defaultValue={book ? book.isbn : ''}
        placeholder="ISBN"
        required
        style={{ marginLeft: 8 }}
      />
      <input
        name="total_copies"
        defaultValue={book ? book.total_copies : ''}
        type="number"
        placeholder="Total copies"
        required
        style={{ marginLeft: 8, width: 120 }}
      />
      <button
        type="submit"
        disabled={loading}
        style={{ marginLeft: 8 }}
      >
        {loading ? 'Saving...' : isEdit ? 'Save' : 'Add'}
      </button>
      {onCancel && (
        <button
          type="button"
          onClick={onCancel}
          style={{ marginLeft: 8 }}
        >
          Cancel
        </button>
      )}
      {error && <p style={{ color: 'red' }}>{error}</p>}
    </form>
  )
}
