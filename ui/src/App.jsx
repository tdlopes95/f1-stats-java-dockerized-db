import { useEffect, useState } from 'react'
import { api } from './api'

export default function App() {
  const [teams, setTeams] = useState([])
  const [seasons, setSeasons] = useState([])
  const [seasonId, setSeasonId] = useState(null)
  const [races, setRaces] = useState([])
  const [leaderboard, setLeaderboard] = useState([])

  useEffect(() => {
    api.teams().then(setTeams).catch(console.error)
    api.seasons().then(s => {
      setSeasons(s)
      if (s?.length) setSeasonId(s[0].id)
    }).catch(console.error)
  }, [])

  useEffect(() => {
    if (!seasonId) return
    api.racesOf(seasonId).then(setRaces).catch(console.error)
    api.teamLeader(seasonId, 'RACE').then(setLeaderboard).catch(console.error)
  }, [seasonId])

  return (
    <div style={{ padding: 16, fontFamily: 'system-ui, sans-serif' }}>
      <h1>F1 Stats — UI</h1>

      <section>
        <h2>Season</h2>
        <select value={seasonId ?? ''} onChange={e => setSeasonId(Number(e.target.value))}>
          {seasons.map(s => <option key={s.id} value={s.id}>{s.year}</option>)}
        </select>
      </section>

      <section>
        <h2>Teams</h2>
        <ul>{teams.map(t => <li key={t.id}>{t.name}</li>)}</ul>
      </section>

      <section>
        <h2>Races</h2>
        <ol>{races.map(r => <li key={r.id}>{r.round}. {r.name} — {r.raceDate || 'TBD'}</li>)}</ol>
      </section>

      <section>
        <h2>Team Leaderboard (RACE)</h2>
        <ol>{leaderboard.map((row, i) =>
          <li key={i}>{row.teamName ?? row.team ?? 'Team'}: {row.totalPoints} pts</li>
        )}</ol>
      </section>
    </div>
  )
}