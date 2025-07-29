export async function getDashboard(token) {
  const response = await fetch('http://localhost:3000/api/dashboard', {
    headers: {
      'Authorization': `Bearer ${token}`
    }
  });
  if (!response.ok) throw new Error('Unauthorized');
  return response.json();
}
