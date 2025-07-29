import { useState } from 'react'

export default function Signup({ onSignup, onCancel }) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setSuccess('')
    setLoading(true)
    try {
      const response = await fetch('http://localhost:3000/api/signup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ user: { email, password } })
      })
      if (!response.ok) throw new Error('Erro ao cadastrar')
      setSuccess('Cadastro realizado com sucesso! Faça login.')
      setEmail('')
      setPassword('')
      if (onSignup) onSignup()
    } catch {
      setError('Não foi possível cadastrar. Tente outro email.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <form onSubmit={handleSubmit} style={{ marginBottom: 20 }}>
      <h3>Cadastro</h3>
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
      <button type="submit" disabled={loading}>{loading ? 'Cadastrando...' : 'Cadastrar'}</button>
      <button type="button" onClick={onCancel} style={{ marginLeft: 10 }}>Voltar</button>
      {error && <p style={{ color: 'red' }}>{error}</p>}
      {success && <p style={{ color: 'green' }}>{success}</p>}
    </form>
  )
}
