// src/services/authService.js

export async function login(email, password) {
  const response = await fetch('http://localhost:3000/api/login', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ user: { email, password } })
  });
  if (!response.ok) throw new Error('Login failed');
  const data = await response.json();
  return { response, data };
}

export function logout() {
  localStorage.removeItem('token');
}
