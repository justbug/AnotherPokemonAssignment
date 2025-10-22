# Data Model – Pokemon Silhouette Quiz

## Domain Entities

### PokemonQuizEntry
- **Source**: Supabase `GET /v1/pokemon`
- **Fields**:
  - `id` (int, required) – unique identifier used for detail lookup
  - `name` (String, required) – lowercase Pokemon name used in options and title casing after formatting
- **Notes**:
  - Response set cached in memory and reused across rounds.
  - Total count provided by API can be used to validate pagination completeness but not required for core loop.

### PokemonQuizDetail
- **Source**: Supabase `GET /v1/pokemon/{id}`
- **Fields**:
  - `id` (int, required) – must match requested Pokemon ID
  - `name` (String, required) – canonical name, reused for “It’s {Name}” copy
  - `silhouetteUrl` (Uri, required) – used for pre-guess image
  - `officialUrl` (Uri, required) – used for reveal image
  - `createdAt` (DateTime, optional) – informational; not surfaced in UI
- **Validation**:
  - URLs must be HTTPS and non-empty; fall back to placeholder image when invalid.

### QuizRound
- **Fields**:
  - `correct` (`PokemonQuizDetail`, required)
  - `options` (`List<PokemonQuizOption>`, length = 3, required)
  - `status` (`QuizRoundStatus`, required) – `loading`, `ready`, `revealed`, `error`
  - `countdownRemaining` (`int`, optional) – seconds left during reveal; null outside reveal.
- **Rules**:
  - `options` must contain exactly one option where `isCorrect == true`.
  - All option names must be unique within the round.

### PokemonQuizOption
- **Fields**:
  - `id` (int, required)
  - `displayName` (String, required) – capitalized for UI
  - `isCorrect` (bool, required)
  - `isSelected` (bool, required, default false)
  - `feedbackIcon` (`QuizOptionFeedback`, derived) – `check`, `x`, or `none` based on `isCorrect` and `isSelected` once revealed.

## Derived / Supporting Models

### QuizRoundStatus (enum)
- `loading` – fetching initial data or refreshing round.
- `ready` – silhouette + options ready, awaiting user guess.
- `revealed` – answer shown, countdown active.
- `error` – unrecoverable failure; UI shows retry.

### QuizCountdown
- Represents countdown timer state for reveal flow.
- **Fields**:
  - `startSeconds` (int, default 3)
  - `currentSeconds` (int) – decreases each tick.
  - `isActive` (bool)
- Implemented via timer in bloc; stored in state for UI binding.

## State Management (BLoC) Outline

### Events
- `QuizInitialized` – trigger initial list fetch + first round generation.
- `QuizOptionSelected` – payload: `optionId`; transitions to reveal state.
- `QuizCountdownTicked` – payload: remaining seconds; emitted every second after reveal.
- `QuizCountdownCompleted` – resets to next round.
- `QuizRetryRequested` – retriggers list/detail fetch after recoverable errors.

### States
- `QuizStateLoading` – indicates first load; shows progress indicator.
- `QuizStateReady` – exposes:
  - `round` (`QuizRound`)
  - `silhouetteUrl` (Uri from `round.correct.silhouetteUrl`)
  - `options` (3 entries)
- `QuizStateReveal` – extends ready state with:
  - `officialImageUrl`
  - `message` (`It’s {Name}`)
  - `countdownRemaining`
- `QuizStateError` – message + retry flag.

### Transitions
1. `QuizInitialized` → `QuizStateLoading`
2. On successful list fetch:
   - Fetch detail for chosen correct Pokemon
   - Build round → `QuizStateReady`
3. `QuizOptionSelected` → `QuizStateReveal` (locks options, shows message, starts countdown)
4. `QuizCountdownTicked` updates same `QuizStateReveal` with decremented timer
5. `QuizCountdownCompleted` → next `QuizStateLoading` (if needing new detail) or `QuizStateReady` once round built
6. Any fetch failure → `QuizStateError`

## Relationships & Data Flow
1. Supabase list response → map to `PokemonQuizEntry` list (cached).
2. Round generation:
   - Sample 3 entries, designate one as correct.
   - Fetch detail for correct entry only (silhouette + official art).
   - Compose `PokemonQuizOption` list from sampled entries.
3. UI observes bloc states:
   - `QuizStateReady` uses silhouette image + option buttons.
   - `QuizStateReveal` swaps to official art, displays message, and shows icon states.
4. Countdown triggers `QuizCountdownTicked` events until auto-reset.

## Validation Rules
- Reject rounds if cached list < 3 entries; surface error + retry prompt.
- On image load failure, emit option to retry round but keep countdown to avoid stalls.
- Consecutive rounds may include the same Pokemon; no additional exclusion logic required.
