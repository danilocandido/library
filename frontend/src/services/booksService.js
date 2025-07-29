// src/services/booksService.js

export async function getBooks(token) {
  const response = await fetch('http://localhost:3000/api/books', {
    headers: {
      'Authorization': `Bearer ${token}`
    }
  })
  if (!response.ok) throw new Error('Unauthorized');
  return response.json();
}
