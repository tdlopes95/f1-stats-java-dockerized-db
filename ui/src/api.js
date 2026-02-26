const API_BASE = import.meta.env.VITE_API_BASE || ''; // leave empty in dev (proxy)

async function getJSON(path) {
  const res = await fetch(`${API_BASE}${path}`);
  if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
  return res.json();
}

export const api = {
  teams:        () => getJSON('/api/teams'),
  seasons:      () => getJSON('/api/seasons'),
  racesOf:      (seasonId) => getJSON(`/api/season/${seasonId}/races`),
  teamLeader:   (seasonId, type) => getJSON(
                    type
                      ? `/api/stats/season/${seasonId}/team-leaderboard?type=${encodeURIComponent(type)}`
                      : `/api/stats/season/${seasonId}/team-leaderboard`
                  ),
  driverLeader: (seasonId, type) => getJSON(
                    type
                      ? `/api/stats/season/${seasonId}/driver-leaderboard?type=${encodeURIComponent(type)}`
                      : `/api/stats/season/${seasonId}/driver-leaderboard`
                  ),
};