import React, { useState } from 'react'
import BookItem from './BookItem'

export default function Search({ token, user, onBack }) {
  const [query, setQuery] = useState('')
  const [results, setResults] = useState([])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  const handleSearch = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)
    try {
      const response = await fetch(
        `http://localhost:3000/api/books/search?q=${encodeURIComponent(query)}`,
        {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        }
      )
      if (!response.ok) throw new Error('Failed to search books')
      const data = await response.json()
      setResults(data)
    } catch {
      setError('Could not search books')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div style={{ marginBottom: 20 }}>
      <h2>Search Books</h2>
      <form onSubmit={handleSearch} style={{ marginBottom: 16 }}>
        <input
          type="text"
          placeholder="Title, author or genre"
          value={query}
          onChange={e => setQuery(e.target.value)}
          required
        />
        <button type="submit" style={{ marginLeft: 8 }}>Search</button>
        <button type="button" onClick={onBack} style={{ marginLeft: 8 }}>
          Back
        </button>
      </form>
      {loading && <p>Searching...</p>}
      {error && <p style={{ color: 'red' }}>{error}</p>}
      <ul>
        {results.map(book => (
          <BookItem
            key={book.id}
            book={book}
            userId={user.id}
            token={token}
            userRole={user.role}
          />
        ))}
      </ul>
    </div>
  )
}
