import { useEffect, useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { api } from '../api'

export default function HomePage() {
  const [seasons, setSeasons] = useState([])
  const [seasonId, setSeasonId] = useState(null)

  const [teamType, setTeamType] = useState('RACE') // 'RACE' | 'SPRINT' | null
  const [teamTable, setTeamTable] = useState([])
  const [driverType, setDriverType] = useState('RACE')
  const [driverTable, setDriverTable] = useState([])

  const [status, setStatus] = useState('loading')
  const [err, setErr] = useState(null)

  const nav = useNavigate()

  const sortedSeasons = useMemo(
    () => [...seasons].sort((a, b) => (a.year ?? 0) - (b.year ?? 0)),
    [seasons]
  )

  useEffect(() => {
    (async () => {
      try {
        setStatus('loading')
        const s = await api.seasons()
        setSeasons(s)
        if (s?.length) {
          const last = [...s].sort((a,b) => (a.year ?? 0)-(b.year ?? 0)).at(-1)
          setSeasonId(last?.id ?? s[0].id)
        }
        setStatus('ok')
      } catch (e) { setErr(e); setStatus('error') }
    })()
  }, [])

  useEffect(() => {
    if (!seasonId) return
    ;(async () => {
      try {
        const table = await api.teamLeaderboard(seasonId, teamType)
        setTeamTable(table ?? [])
      } catch { setTeamTable([]) }
    })()
  }, [seasonId, teamType])

  useEffect(() => {
    if (!seasonId) return
    ;(async () => {
      try {
        const table = await api.driverLeaderboard(seasonId, driverType)
        setDriverTable(table ?? [])
      } catch { setDriverTable([]) }
    })()
  }, [seasonId, driverType])

  if (status === 'loading') return <p>Loading seasons…</p>
  if (status === 'error')   return <p style={{color:'crimson'}}>Failed to load seasons: {String(err)}</p>

  return (
    <div>
      <section style={{ display:'flex', gap: 12, alignItems:'center', flexWrap:'wrap' }}>
        <h2 style={{ margin: 0 }}>Season</h2>
        <select value={seasonId ?? ''} onChange={e => setSeasonId(Number(e.target.value))}>
          {sortedSeasons.map(s => <option key={s.id} value={s.id}>{s.year}</option>)}
        </select>
        <button onClick={() => nav(`/season/${seasonId}`)}>View races</button>
      </section>

      <section style={{ marginTop: 24 }}>
        <div style={{ display:'flex', alignItems:'baseline', gap: 12 }}>
          <h3 style={{ margin: 0 }}>Team Leaderboard</h3>
          <Toggle value={teamType} onChange={setTeamType} />
        </div>
        {!teamTable?.length ? <p>No data yet.</p> : (
          <ol>
            {teamTable.map((row, i) =>
              <li key={i}>
                {(row.teamName ?? row.team ?? 'Team')}: {row.totalPoints ?? row.points ?? 0} pts
              </li>
            )}
          </ol>
        )}
      </section>

      <section style={{ marginTop: 24 }}>
        <div style={{ display:'flex', alignItems:'baseline', gap: 12 }}>
          <h3 style={{ margin: 0 }}>Driver Leaderboard</h3>
          <Toggle value={driverType} onChange={setDriverType} />
        </div>
        {!driverTable?.length ? <p>No data yet.</p> : (
          <ol>
            {driverTable.map((row, i) => {
              const driverName = row.driverName ?? row.driver ?? row.name ?? 'Driver'
              const driverId   = row.driverId   ?? row.id
              const points     = row.totalPoints ?? row.points ?? 0
              return (
                <li key={i}>
                  {driverId
                    ? <a href={`/driver/${driverId}`}>{driverName}</a>
                    : driverName
                  } — {points} pts
                </li>
              )
            })}
          </ol>
        )}
      </section>
    </div>
  )
}

function Toggle({ value, onChange }) {
  return (
    <div style={{ display:'inline-flex', gap: 6 }}>
      <label>
        <input type="radio" name="type_team_driver" checked={value==='RACE'} onChange={() => onChange('RACE')} />
        {' '}Race
      </label>
      <label>
        <input type="radio" name="type_team_driver" checked={value==='SPRINT'} onChange={() => onChange('SPRINT')} />
        {' '}Sprint
      </label>
      <label>
        <input type="radio" name="type_team_driver" checked={!value} onChange={() => onChange(null)} />
        {' '}All
      </label>
    </div>
  )
}