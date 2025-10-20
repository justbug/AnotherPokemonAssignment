<!--
Sync Impact Report
Version change: (initial) → 1.0.0
Modified principles:
- (new) → I. Cross-Platform Feature Parity (NON-NEGOTIABLE)
- (new) → II. Typed API Contracts & Shared Domain Models
- (new) → III. State Management Discipline
- (new) → IV. Test-Centric Delivery
- (new) → V. Resilient Favorites Persistence
Added sections:
- Core Principles
- Platform Architecture Standards
- Development Workflow & Tooling
Removed sections: None
Templates requiring updates:
- ⚠ pending .specify/templates/plan-template.md (embed parity gates and platform structure)
- ⚠ pending .specify/templates/spec-template.md (call out dual-platform acceptance criteria)
- ⚠ pending .specify/templates/tasks-template.md (provide iOS + Flutter task scaffolding)
Follow-up TODOs: None
-->
# Another Pokemon Assignment Constitution

## Core Principles

### I. Cross-Platform Feature Parity (NON-NEGOTIABLE)
Both the Swift and Flutter clients MUST deliver the same Pokémon list, detail, and
favorites experiences. A story is complete only when acceptance criteria are
verified on both platforms, including UI copy, navigation, loading states, and
error flows. Any temporary divergence MUST have an owner, issue link, and fix
date; otherwise revert the change. Shared data payloads, images, and pagination
rules stay consistent across codebases.

### II. Typed API Contracts & Shared Domain Models
All networking goes through the established `APIClient`/`RequestBuilder` layers
with typed requests, responses, and error envelopes. Domain models (e.g.,
`Pokemon`, `LocalPokemon`) MUST remain semantically equivalent across Swift and
Flutter, with migrations scheduled together when fields change. Breaking API or
model updates REQUIRE contract tests for both platforms, regenerated serializers,
and documentation updates before merge. UI surfaces actionable error messages
derived from typed failures—generic or silent error handling is forbidden.

### III. State Management Discipline
Flutter flows MUST use BLoC with explicit events and states as the single source
of truth; iOS view controllers remain passive and delegate business logic to
MVVM view models backed by UseCases. Business rules stay in repositories, use
cases, blocs, or view models—never in widgets or view controllers. Favorites or
detail updates propagate through the shared blocs/observables rather than manual
state mutation. Introduce new state machines only with documented transition
tables and tests that lock expected sequences.

### IV. Test-Centric Delivery
Every repository, service, use case, bloc, and view model change ships with
automated tests that cover success, loading, pagination, error, and favorites
paths. `xcodebuild test` (Swift) and `flutter test` (Flutter) MUST pass locally
and in CI before merge. Fixtures or builders drive deterministic test data; no
ad-hoc network stubbing. Code generation updates (Freezed, JSON serialization,
mockito) are regenerated and committed with the change—no stale artifacts.

### V. Resilient Favorites Persistence
Favorite toggles MUST be idempotent and survive restarts via the
`UserDefaultsStore` (Swift) and `LocalPokemonService` backed by
`SharedPreferences` (Flutter). Local caches default to remote truth when stale
but never drop favorite selections. Storage or schema changes require migration
plans, tests for upgrade/downgrade behavior, and user-visible recovery paths for
failures. UI states MUST surface persistence errors with retry affordances
instead of silently ignoring them.

## Platform Architecture Standards
The project maintains two production clients that share a common domain and API
contract.

- Swift code stays organized by feature folders (`List`, `Detail`, `Favorite`,
  `Service`, `UseCase`, `Store`) with dependencies injected via initializers or
  protocol abstractions—no new singletons beyond application entry points.
- Flutter code adheres to repository/service/BLoC layering. `flutter_bloc`,
  `freezed`, and `json_serializable` artifacts are regenerated via
  `flutter pub run build_runner build --delete-conflicting-outputs` whenever
  models or events change. Widgets limit themselves to rendering and dispatching
  events.
- Both clients enforce the shared networking surface: base URL, pagination size
  (30 rows per request), error envelopes, and domain model fields must match.
  Any backend adjustments trigger synchronized updates and test refreshes.

## Development Workflow & Tooling
- Feature planning references this constitution to enumerate parity checks,
  typed contract updates, and test requirements inside plan/spec/tasks outputs.
- Implementation branches include checklists for dual-platform completion,
  code generation refresh, and storage migration verification where applicable.
- Before requesting review, run `xcodebuild test` for iOS targets (including
  scheme-specific unit suites) and `flutter test` with all mockito-generated
  mocks refreshed.
- CI pipelines MUST block merges on failing parity, lint, or test gates and
  publish artifacts documenting feature coverage for both platforms.
- Cursor rule packs remain authoritative for low-level code style; conflicts are
  settled in favor of this constitution when they differ.

## Governance
This constitution governs all Swift and Flutter development in this repository
and supersedes conflicting legacy guidance. Amendments require joint approval
from the iOS and Flutter leads plus the product owner, documented via pull
request with rationale, version bump, and updated Sync Impact Report. Semantic
versioning applies: MAJOR for principle removals or incompatible governance
changes, MINOR for new principles or material scope expansion, PATCH for
clarifications. Compliance reviews occur during plan/spec authoring and at code
review; reviewers MUST confirm parity, typed contract coverage, testing, and
persistence safeguards before approving.

**Version**: 1.0.0 | **Ratified**: 2025-10-20 | **Last Amended**: 2025-10-20
