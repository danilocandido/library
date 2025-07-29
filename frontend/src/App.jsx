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
    <div className="App">
      <h1>Library Dashboard</h1>
      {!token ? (
        <AuthForm onAuth={handleAuth} />
      ) : showSearch ? (
        <Search token={token} user={user} onBack={() => setShowSearch(false)} />
      ) : (
        <div>
          <UserInfo email={user.email} role={user.role} />
          <button onClick={handleLogout} style={{ marginBottom: 20 }}>Logout</button>
          <button onClick={() => setShowSearch(true)} style={{ marginLeft: 10, marginBottom: 20 }}>Pesquisar</button>
          {user.role === 'librarian' && !showBookForm && (
            <button onClick={() => setShowBookForm(true)} style={{ marginBottom: 20, marginLeft: 10 }}>Adicionar Livro</button>
          )}
          {showBookForm && (
            <BookForm token={token} onSave={() => setShowBookForm(false)} book={editBook} onCancel={() => { setShowBookForm(false); setEditBook(null) }} />
          )}
          {loading ? (
            <p>Loading...</p>
          ) : dashboard ? (
            <Dashboard dashboard={dashboard} user={user} token={token} />
          ) : null}
        </div>
      )}
    </div>
  )
}

export default App
