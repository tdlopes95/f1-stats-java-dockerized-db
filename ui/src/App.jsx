import { Routes, Route, Link, Navigate } from 'react-router-dom'
import HomePage from './pages/HomePage.jsx'
import SeasonPage from './pages/SeasonPage.jsx'
import RacePage from './pages/RacePage.jsx'
import DriverPage from './pages/DriverPage.jsx'

export default function App() {
  return (
    <div style={{ padding: 16, maxWidth: 1000, margin: '0 auto', fontFamily: 'system-ui, sans-serif' }}>
      <header style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h1 style={{ margin: 0 }}>
          <Link to="/" style={{ textDecoration: 'none' }}>F1 Stats</Link>
        </h1>
        <nav style={{ display: 'flex', gap: 12 }}>
          <Link to="/">Home</Link>
        </nav>
      </header>

      <main style={{ marginTop: 24 }}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/season/:seasonId" element={<SeasonPage />} />
          <Route path="/race/:raceId" element={<RacePage />} />
          <Route path="/driver/:driverId" element={<DriverPage />} />
          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </main>
    </div>
  )
}