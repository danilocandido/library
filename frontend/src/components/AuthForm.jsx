import { useState } from 'react'
import { login } from '../services/authService'
import Signup from './Signup'

export default function AuthForm({ onAuth }) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const [showSignup, setShowSignup] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)
    try {
      const { response, data } = await login(email, password)
      const authHeader = response.headers.get('authorization')
      let token = ''
      if (authHeader && authHeader.startsWith('Bearer ')) {
        token = authHeader.replace('Bearer ', '')
      }
      if (!token) {
        setError('Token not found in authorization header')
        setLoading(false)
        return
      }
      const userInfo = data.data ? {
        email: data.data.email,
        role: data.data.role,
        id: data.data.id
      } : { email: '', role: '', id: null }
      onAuth(token, userInfo)
      localStorage.setItem('token', token)
      localStorage.setItem('userInfo', JSON.stringify(userInfo))
    } catch {
      setError('Invalid credentials')
    } finally {
      setLoading(false)
    }
  }

  if (showSignup) {
    return (
      <Signup
        onSignup={() => setShowSignup(false)}
        onCancel={() => setShowSignup(false)}
      />
    )
  }

  return (
    <form onSubmit={handleSubmit} style={{ marginBottom: 20 }}>
      <input
        type="email"
        placeholder="Email"
        value={email}
        onChange={e => setEmail(e.target.value)}
        required
      />
      <input
        type="password"
        placeholder="Password"
        value={password}
        onChange={e => setPassword(e.target.value)}
        required
      />
      <button
        type="submit"
        disabled={loading}
      >
        {loading ? 'Logging in...' : 'Login'}
      </button>
      <button
        type="button"
        onClick={() => setShowSignup(true)}
        style={{ marginLeft: 10 }}
      >
        Sign up
      </button>
      {error && (
        <p style={{ color: 'red' }}>{error}</p>
      )}
    </form>
  )
}
