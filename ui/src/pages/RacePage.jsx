// ui/src/pages/RacePage.jsx
import { useParams } from 'react-router-dom'
import { useEffect, useState } from 'react'
import { api } from '../api'

export default function RacePage() {
  const { raceId } = useParams()
  const [race, setRace] = useState(null)
  const [sessions, setSessions] = useState([])
  const [selectedSession, setSelectedSession] = useState(null)
  const [results, setResults] = useState([])
  const [status, setStatus] = useState('loading')
  const [err, setErr] = useState(null)

  useEffect(() => {
    let cancel = false
    ;(async () => {
      try {
        setStatus('loading')
        const [r, sess] = await Promise.all([ api.race(raceId), api.raceSessions(raceId) ])
        if (cancel) return
        setRace(r)
        // show RACE first if present, else first available
        const ordered = [...sess].sort((a,b) => (a.sessionType === 'RACE' ? -1 : 1))
        setSessions(ordered)
        setSelectedSession(ordered[0]?.id ?? null)
        setStatus('ok')
      } catch (e) { if (!cancel) { setErr(e); setStatus('error') } }
    })()
    return () => { cancel = true }
  }, [raceId])

  useEffect(() => {
    if (!selectedSession) { setResults([]); return }
    let cancel = false
    ;(async () => {
      try {
        const rows = await api.sessionResults(selectedSession)
        if (!cancel) setResults(rows)
      } catch (e) { if (!cancel) setResults([]) }
    })()
    return () => { cancel = true }
  }, [selectedSession])

  if (status === 'loading') return <p>Loading race…</p>
  if (status === 'error')   return <p style={{color:'crimson'}}>Failed to load: {String(err)}</p>

  return (
    <>
      <h2>{race?.round ? `${race.round}. ${race.name}` : race?.name}</h2>
      {race?.raceDate && <p>{race.raceDate}</p>}

      <div style={{ display:'flex', gap: 12, flexWrap:'wrap', margin:'8px 0' }}>
        {sessions.map(s =>
          <button
            key={s.id}
            onClick={() => setSelectedSession(s.id)}
            style={{
              padding: '6px 10px',
              border: '1px solid #ccc',
              background: s.id === selectedSession ? '#eef' : '#fff',
              cursor:'pointer'
            }}>
            {s.sessionType === 'RACE' ? 'Race' : 'Sprint'}
            {s.sessionNo ? ` #${s.sessionNo}` : ''}
          </button>
        )}
      </div>

      <section style={{ marginTop: 16 }}>
        <h3>Results</h3>
        {!results?.length ? <p>No results for this selection.</p> : (
          <table style={{ borderCollapse:'collapse', width:'100%' }}>
            <thead>
              <tr>
                <th style={{textAlign:'left',borderBottom:'1px solid #ddd'}}>Pos</th>
                <th style={{textAlign:'left',borderBottom:'1px solid #ddd'}}>Driver</th>
                <th style={{textAlign:'left',borderBottom:'1px solid #ddd'}}>Team</th>
                <th style={{textAlign:'left',borderBottom:'1px solid #ddd'}}>Pts</th>
              </tr>
            </thead>
            <tbody>
              {results.map((row, i) => (
                <tr key={i}>
                  <td>{row.position ?? '-'}</td>
                  <td>{row.driverName}</td>
                  <td>{row.teamName}</td>
                  <td>{row.points}</td>
                </tr>
              ))}
            </tbody>
          </table>
        )}
      </section>
    </>
  )
}