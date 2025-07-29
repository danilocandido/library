import { useEffect, useState } from 'react'
import AuthForm from './components/AuthForm'
import { logout as logoutService } from './services/authService'
import { getDashboard } from './services/dashboardService'
import UserInfo from './components/UserInfo'
import BookForm from './components/BookForm'
import Search from './components/Search'
import Dashboard from './components/Dashboard'

function App() {
  const [dashboard, setDashboard] = useState(null)
  const [loading, setLoading] = useState(false)
  const [token, setToken] = useState(localStorage.getItem('token') || '')
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem('userInfo')
    return saved ? JSON.parse(saved) : { email: '', role: '', id: null }
  })
  const [showBookForm, setShowBookForm] = useState(false)
  const [editBook, setEditBook] = useState(null)
  const [showSearch, setShowSearch] = useState(false)

  useEffect(() => {
    if (!token) {
      setDashboard(null)
      return;
    }
    setLoading(true);
    getDashboard(token)
      .then(data => {
        setDashboard(data.dashboard)
        setLoading(false)
      })
      .catch(() => setLoading(false))
  }, [token])

  const handleAuth = (newToken, userInfo) => {
    setToken(newToken)
    localStorage.setItem('token', newToken)
    if (userInfo) {
      setUser(userInfo)
      localStorage.setItem('userInfo', JSON.stringify(userInfo))
    }
  }

  const handleLogout = () => {
    setToken('');
    logoutService();
    setDashboard(null);
    setUser({ email: '', role: '', id: null })
    localStorage.removeItem('userInfo')
  }

  // handleBookSave pode ser ajustado para atualizar a dashboard se necessário

  return (
    <div style={{ width: '100vw', minHeight: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
      <div style={{ width: '100%', maxWidth: 700 }}>
        <h1 style={{ textAlign: 'center' }}>Library Dashboard</h1>
        {!token ? (
          <AuthForm onAuth={handleAuth} />
        ) : showSearch ? (
          <Search token={token} user={user} onBack={() => setShowSearch(false)} />
        ) : showBookForm ? (
          <BookForm token={token} onSave={() => setShowBookForm(false)} book={editBook} onCancel={() => { setShowBookForm(false); setEditBook(null) }} />
        ) : (
          <div style={{ textAlign: 'center' }}>
            <UserInfo email={user.email} role={user.role} />
            <div style={{ display: 'flex', justifyContent: 'center', gap: 16, marginBottom: 20 }}>
              <button onClick={handleLogout}>Logout</button>
              <button onClick={() => setShowSearch(true)}>Pesquisar</button>
              {user.role === 'librarian' && (
                <button onClick={() => { setEditBook(null); setShowBookForm(true) }}>
                  Book Register
                </button>
              )}
            </div>
            {loading ? (
              <p>Loading...</p>
            ) : dashboard ? (
              <Dashboard dashboard={dashboard} user={user} token={token} />
            ) : null}
          </div>
        )}
      </div>
    </div>
  )
}

export default App
