const API_BASE = import.meta.env.VITE_API_BASE || ''; // leave empty in dev (Vite proxy)

async function getJSON(path) {
  const res = await fetch(`${API_BASE}${path}`);
  if (!res.ok) throw new Error(`${res.status} ${res.statusText}`);
  return res.json();
}

/** Core data **/
export const api = {
  teams:        () => getJSON('/api/teams'),
  seasons:      () => getJSON('/api/seasons'),
  racesOf:      (seasonId) => getJSON(`/api/season/${seasonId}/races`),

  // Race details & sessions (RacePage)
  race:           (raceId) => getJSON(`/api/race/${raceId}`),
  raceSessions:   (raceId) => getJSON(`/api/race/${raceId}/sessions`),
  sessionResults: (sessionId) => getJSON(`/api/race-session/${sessionId}/results`),

  /** Stats */
  teamLeaderboard:   (seasonId, type) =>
    getJSON(type
      ? `/api/stats/season/${seasonId}/team-leaderboard?type=${encodeURIComponent(type)}`
      : `/api/stats/season/${seasonId}/team-leaderboard`),

  driverLeaderboard: (seasonId, type) =>
    getJSON(type
      ? `/api/stats/season/${seasonId}/driver-leaderboard?type=${encodeURIComponent(type)}`
      : `/api/stats/season/${seasonId}/driver-leaderboard`),

  driverSummary:       (driverId) => getJSON(`/api/stats/driver/${driverId}/summary`),
  driverSeasonSummary: (driverId, seasonId) =>
    getJSON(`/api/stats/driver/${driverId}/season/${seasonId}/summary`),
};