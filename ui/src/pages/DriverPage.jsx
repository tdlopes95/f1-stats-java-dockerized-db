import { useEffect, useMemo, useState } from 'react'
import { useParams } from 'react-router-dom'
import { api } from '../api'

export default function DriverPage() {
  const { driverId } = useParams()
  const [seasons, setSeasons] = useState([])
  const [seasonId, setSeasonId] = useState(null)

  const [summary, setSummary] = useState(null)
  const [status, setStatus] = useState('loading')
  const [err, setErr] = useState(null)

  useEffect(() => {
    (async () => {
      try {
        const s = await api.seasons()
        setSeasons(s)
        if (s?.length) {
          const last = [...s].sort((a,b) => (a.year ?? 0)-(b.year ?? 0)).at(-1)
          setSeasonId(last?.id ?? s[0].id)
        }
      } catch {}
    })()
  }, [])

  useEffect(() => {
    if (!driverId || !seasonId) return
    ;(async () => {
      try {
        setStatus('loading')
        const s = await api.driverSeasonSummary(driverId, seasonId)
        setSummary(s); setStatus('ok')
      } catch (e) { setErr(e); setStatus('error') }
    })()
  }, [driverId, seasonId])

  const driverName = summary?.driverName ?? summary?.name ?? `Driver ${driverId}`
  const totalPoints = summary?.totalPoints ?? summary?.points ?? 0
  const racePoints  = summary?.totalRacePoints ?? summary?.racePoints ?? totalPoints
  const avgRacePts  = summary?.averageRacePoints
                    ?? summary?.avgRacePoints
                    ?? (summary?.raceCount ? (racePoints / summary.raceCount) : undefined)

  const seasonOptions = useMemo(
    () => [...seasons].sort((a,b) => (a.year ?? 0)-(b.year ?? 0)),
    [seasons]
  )

  if (!seasonId) return <p>Loading seasons…</p>
  if (status === 'loading') return <p>Loading driver summary…</p>
  if (status === 'error')   return <p style={{color:'crimson'}}>Failed to load summary: {String(err)}</p>

  return (
    <>
      <h2>{driverName}</h2>

      <div style={{ display:'flex', gap: 12, alignItems:'center' }}>
        <label>
          Season{' '}
          <select value={seasonId} onChange={e => setSeasonId(Number(e.target.value))}>
            {seasonOptions.map(s => <option key={s.id} value={s.id}>{s.year}</option>)}
          </select>
        </label>
      </div>

      <section style={{ marginTop: 16 }}>
        <dl style={{ display:'grid', gridTemplateColumns:'max-content 1fr', gap:'8px 16px' }}>
          <dt>Total points (all)</dt>
          <dd>{totalPoints}</dd>

          <dt>Total points (RACE only)</dt>
          <dd>{racePoints}</dd>

          <dt>Avg points per RACE</dt>
          <dd>{avgRacePts !== undefined ? avgRacePts.toFixed(2) : '—'}</dd>
        </dl>
      </section>
    </>
  )
}