import { useParams, Link } from 'react-router-dom'
import { useEffect, useMemo, useState } from 'react'
import { api } from '../api'

export default function SeasonPage() {
  const { seasonId } = useParams()
  const [races, setRaces] = useState(null)
  const [status, setStatus] = useState('loading')
  const [err, setErr] = useState(null)

  useEffect(() => {
    (async () => {
      try {
        setStatus('loading')
        const data = await api.racesOf(seasonId)
        setRaces(data ?? [])
        setStatus('ok')
      } catch (e) { setErr(e); setStatus('error') }
    })()
  }, [seasonId])

  const ordered = useMemo(
    () => (races ?? []).slice().sort((a,b) => (a.round ?? 0) - (b.round ?? 0)),
    [races]
  )

  if (status === 'loading') return <p>Loading races…</p>
  if (status === 'error')   return <p style={{color:'crimson'}}>Failed to load: {String(err)}</p>

  return (
    <>
      <h2>Season {seasonId}</h2>
      {!ordered.length ? <p>No races found.</p> : (
        <ol>
          {ordered.map(r =>
            <li key={r.id}>
              <Link to={`/race/${r.id}`}>{r.round ? `${r.round}. ` : ''}{r.name}</Link>
              {r.raceDate ? ` — ${r.raceDate}` : ''}
            </li>
          )}
        </ol>
      )}
    </>
  )
}