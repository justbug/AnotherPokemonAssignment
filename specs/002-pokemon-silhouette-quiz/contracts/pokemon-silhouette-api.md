# Contract – Pokemon Silhouette API Consumption

## Base Configuration
- **Host**: `https://your-project.supabase.co`
- **Auth**: Supabase anon key handled by `supabase_flutter` client (Functions API)
- **Function Path**: `/functions/v1/pokemon`

## Endpoint: List Pokemon Summaries

```
GET /functions/v1/pokemon
Query: 
  limit (optional, int, default 30, max 100)
  offset (optional, int, default 0)
```

### Expected Response
```json
{
  "data": [
    { "id": 1, "name": "bulbasaur" }
  ],
  "total": 151,
  "limit": 30,
  "offset": 0
}
```

### Client Contract
- Treat `data` as authoritative list; cache in memory after first request.
- Guard against `data.length < 3` by showing error + retry CTA.
- Only initial load should hit network; subsequent rounds use cached list.

## Endpoint: Pokemon Detail with Silhouette

```
GET /functions/v1/pokemon/{id}
Path:
  id (int) – Pokemon identifier from list response
```

### Expected Response
```json
{
  "id": 1,
  "name": "bulbasaur",
  "silhouette_url": "https://.../silhouettes/1.png",
  "official_url": "https://.../official/1.png",
  "created_at": "2024-01-15T10:30:00Z"
}
```

### Client Contract
- On success, surface silhouette before guess and official art after reveal.
- Validate both URLs; if missing, show placeholder imagery and allow retry.
- Errors:
  - `404` → display “Pokemon data unavailable” with retry option.
  - `5xx` → show generic retry messaging; logged for telemetry.

## Error Envelope
```json
{
  "error": "not found"
}
```
- Treat any non-200 response as failure; propagate user-friendly copy per bloc error state.

## Rate & Caching Notes
- Respect API caching headers; `cached_network_image` handles per-image caching.
- Quiz bloc should debounce multiple detail requests; only one in flight per round.
