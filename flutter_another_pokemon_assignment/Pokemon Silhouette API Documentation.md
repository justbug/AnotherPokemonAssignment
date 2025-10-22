# Pokemon Silhouette API Documentation

## Overview

The Pokemon Silhouette API provides access to Pokemon data with silhouette images. This RESTful API allows mobile applications to fetch Pokemon lists with pagination and individual Pokemon details including their silhouette artwork.

**Base URL:** `https://your-project.supabase.co/functions/v1/pokemon`

## Authentication

No authentication is required. This is a public API that can be accessed directly from mobile applications using the `SUPABASE_ANON_KEY`.

## Endpoints

### 1. Get Pokemon List

Retrieve a paginated list of all Pokemon.

**Endpoint:** `GET /v1/pokemon`

**Query Parameters:**
- `limit` (optional): Number of Pokemon to return (default: 30, max: 100)
- `offset` (optional): Number of Pokemon to skip (default: 0)

**Example Request:**
```bash
curl "https://your-project.supabase.co/functions/v1/pokemon?limit=10&offset=0"
```

**Response:**
```json
{
  "data": [
    {
      "id": 1,
      "name": "bulbasaur"
    },
    {
      "id": 2,
      "name": "ivysaur"
    }
  ],
  "total": 151,
  "limit": 10,
  "offset": 0
}
```

**Response Fields:**
- `data`: Array of Pokemon objects
  - `id`: Pokemon ID (integer)
  - `name`: Pokemon name (string)
- `total`: Total number of Pokemon available (integer)
- `limit`: Number of Pokemon returned in this response (integer)
- `offset`: Number of Pokemon skipped (integer)

### 2. Get Pokemon Detail

Retrieve detailed information about a specific Pokemon including its silhouette image.

**Endpoint:** `GET /v1/pokemon/{id}`

**Path Parameters:**
- `id`: Pokemon ID (integer, required)

**Example Request:**
```bash
curl "https://your-project.supabase.co/functions/v1/pokemon/1"
```

**Response:**
```json
{
  "id": 1,
  "name": "bulbasaur",
  "silhouette_url": "https://your-project.supabase.co/storage/v1/object/public/pokemon-assets/silhouettes/1.png",
  "official_url": "https://your-project.supabase.co/storage/v1/object/public/pokemon-assets/official/1.png",
  "created_at": "2024-01-15T10:30:00Z"
}
```

**Response Fields:**
- `id`: Pokemon ID (integer)
- `name`: Pokemon name (string)
- `silhouette_url`: Direct URL to the Pokemon silhouette image (string)
- `official_url`: Direct URL to the Pokemon official artwork image (string)
- `created_at`: Timestamp when the Pokemon was added to the database (ISO 8601 string)

## Pagination

The list endpoint supports offset-based pagination:

- **Default limit:** 30 Pokemon per request
- **Maximum limit:** 100 Pokemon per request
- **Offset:** Number of Pokemon to skip (0-based)

**Pagination Example:**
```bash
# First page (Pokemon 1-30)
GET /v1/pokemon?limit=30&offset=0

# Second page (Pokemon 31-60)
GET /v1/pokemon?limit=30&offset=30

# Third page (Pokemon 61-90)
GET /v1/pokemon?limit=30&offset=60
```

## Caching

The API implements HTTP caching to improve performance:

- **Cache-Control:** `public, max-age=300, s-maxage=3600, stale-while-revalidate=86400`
- **Browser cache:** 5 minutes (300 seconds)
- **CDN cache:** 1 hour (3600 seconds)
- **Stale-while-revalidate:** 24 hours (86400 seconds)

Mobile applications should implement appropriate caching strategies based on these headers.

## Error Handling

The API returns standard HTTP status codes with JSON error responses:

### 400 Bad Request
```json
{
  "error": "invalid path"
}
```
**When:** Invalid URL path or malformed request

### 404 Not Found
```json
{
  "error": "not found"
}
```
**When:** Pokemon with the specified ID doesn't exist

### 405 Method Not Allowed
```json
{
  "error": "method not allowed"
}
```
**When:** Using HTTP methods other than GET or OPTIONS

### 500 Internal Server Error
```json
{
  "error": "database error"
}
```
or
```json
{
  "error": "server error"
}
```
**When:** Database connection issues or unexpected server errors

## CORS Support

The API supports Cross-Origin Resource Sharing (CORS) for web applications:

- **Access-Control-Allow-Origin:** `*`
- **Access-Control-Allow-Methods:** `GET, OPTIONS`
- **Access-Control-Allow-Headers:** `authorization, x-client-info, apikey, content-type`

## Image Storage

Pokemon silhouette images are stored and publicly accessible:

- **Image format:** PNG with transparent background
- **Image type:** Black silhouettes converted from official artwork

## Rate Limiting

The API implements rate limiting for optimal performance:
- No explicit rate limits for client requests
- Recommended: Implement client-side throttling for optimal performance

## Example Integration

### iOS (Swift)
```swift
// Fetch Pokemon list
let url = URL(string: "https://your-project.supabase.co/functions/v1/pokemon?limit=30&offset=0")!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    // Handle response
}
task.resume()
```

### Flutter (Dart)
```dart
// Fetch Pokemon list
final response = await http.get(
  Uri.parse('https://your-project.supabase.co/functions/v1/pokemon?limit=30&offset=0'),
  headers: {'Content-Type': 'application/json'},
);
```

## Data Source

Pokemon data is sourced from official Pokemon APIs and artwork.

## Support

For technical support or questions about this API, please refer to the project documentation or contact the development team.