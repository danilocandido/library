import React from 'react'

export default function UserInfo({ email, role }) {
  return (
    <div style={{ marginBottom: 10 }}>
      <span><strong>Email:</strong> {email} </span>
      <span style={{ marginLeft: 10 }}><strong>Role:</strong> {role}</span>
    </div>
  )
}
