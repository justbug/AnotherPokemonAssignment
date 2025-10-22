# Feature Specification: Pokemon Silhouette Quiz

**Feature Branch**: `002-pokemon-silhouette-quiz`  
**Created**: 2025-10-23  
**Status**: Draft  
**Input**: User description: "在 flutter app 專案裡，建立一個猜寶可夢的遊戲頁面，使用者會先看到寶可夢的剪影圖 ，圖片下方會有三個寶可夢名字的選項，其中一個是正確寶可夢選項，其他兩個是隨機的寶可夢選項，當使用者點擊其中一個寶可夢選項，便會揭曉答案，寶可夢的剪影圖會換成真正的寶可夢圖片，圖片下方會顯示文字 \"It’s {正確寶可夢名字}\"，正確的選項會附上打勾圖示 （反之錯誤 \"X\" 圖示）。揭曉答案後圖片會顯示倒數文字 (3秒)，倒數時間到，遊戲重來，UI 回到初始狀態"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Identify Pokemon From Silhouette (Priority: P1)

As a player, I want to look at a Pokemon silhouette with three name choices so that I can guess which Pokemon it is.

**Why this priority**: This is the core gameplay loop and must work flawlessly for the feature to provide any value.

**Independent Test**: Can be fully tested by loading a round, verifying the silhouette and three options appear with one correct answer, and ensuring the player can make a selection.

**Acceptance Scenarios**:

1. **Given** the game loads a new round, **When** the player views the screen, **Then** a silhouette image and exactly three distinct Pokemon name options are visible with clear selection affordances.
2. **Given** a new round is displayed, **When** the player inspects the options, **Then** exactly one option matches the silhouette’s correct Pokemon name and the other two options are valid, non-duplicate Pokemon names.

---

### User Story 2 - Reveal Answer Feedback (Priority: P2)

As a player, I want immediate visual confirmation after selecting an option so that I know whether I guessed correctly and see the actual Pokemon.

**Why this priority**: Prompt feedback maintains engagement and teaches players the correct answer, making the game satisfying.

**Independent Test**: Triggered by selecting any option, then verifying the full-color Pokemon image, the “It’s {Name}” message, and correct/incorrect indicators for each option.

**Acceptance Scenarios**:

1. **Given** the player selects an option, **When** the selection is registered, **Then** the silhouette changes to the full Pokemon artwork and the message “It’s {Pokemon Name}” appears below the image using the correct name.
2. **Given** the player selects an option, **When** feedback is shown, **Then** the correct option is marked with a check icon, the chosen wrong option (if any) is marked with an X icon, and all options become non-interactive until the next round.

---

### User Story 3 - Automatic Round Reset (Priority: P3)

As a player, I want the game to automatically restart after a short countdown so that I can continue guessing without extra taps.

**Why this priority**: Automatic pacing keeps players in the flow and removes friction between rounds.

**Independent Test**: After the reveal state begins, verify that a visible 3-second countdown appears, decrements correctly, and transitions the UI back to the initial guessing state with fresh content.

**Acceptance Scenarios**:

1. **Given** the reveal state is active, **When** the countdown reaches zero, **Then** the UI returns to the silhouette view with a new set of options and any previous highlights or messages cleared.
2. **Given** the reveal state is active, **When** fewer than three seconds have elapsed, **Then** the countdown timer remains visible and accurately reflects the remaining time in whole seconds.

### Edge Cases

- Silhouette or reveal image fails to load: show a graceful placeholder and keep gameplay functional (e.g., allow retry or skip to next round).
- Pokemon data source returns fewer than three unique options: block the round from starting and fetch a replacement set without showing incomplete data.
- Player taps multiple times quickly on different options: only the first valid tap should register and all options lock immediately to avoid state conflicts.
- Countdown is interrupted (e.g., app backgrounded mid-countdown): resume correctly or restart the round without revealing stale results.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST present a Pokemon silhouette image and three distinct name options when a new round begins.
- **FR-002**: System MUST ensure exactly one option corresponds to the silhouette’s actual Pokemon and the other two are valid, non-duplicate decoys.
- **FR-003**: System MUST accept a single tap input on any option and disable further input for the remainder of the round.
- **FR-004**: System MUST reveal the full-color Pokemon artwork immediately after a selection and display the message “It’s {Pokemon Name}”.
- **FR-005**: System MUST mark the correct option with a check icon and any incorrect chosen option with an X icon while leaving unselected incorrect options unmarked.
- **FR-006**: System MUST show a prominently visible countdown starting at three seconds once the reveal begins and update it in one-second intervals.
- **FR-007**: System MUST automatically start a fresh round with new content when the countdown reaches zero, clearing previous messages, icons, and selections.
- **FR-008**: System MUST handle missing assets or data gracefully by substituting fallback imagery or retrying data retrieval without crashing the game loop.

### Key Entities *(include if feature involves data)*

- **QuizRound**: Represents a single gameplay instance; includes silhouette image reference, reveal image reference, correct Pokemon name, option list, and countdown duration.
- **PokemonOption**: Represents one selectable answer choice; includes display name, correctness flag, and selection state for showing feedback icons.

## Assumptions

- Pokemon assets (silhouette and full artwork) are available for the same Pokemon identifiers used in the rest of the app.
- The game does not track cumulative scoring or player history; each round is independent.
- Countdown timing tolerates minor device latency (±0.5 seconds) without impacting user perception.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In usability testing, 90% of participants can successfully identify the correct Pokemon (regardless of accuracy) and reach the reveal state within 10 seconds of a round starting.
- **SC-002**: QA sessions confirm that 100% of tested rounds display the correct Pokemon name and matching artwork upon reveal.
- **SC-003**: Countdown reliably transitions to a new round within 3.5 seconds of reveal in 95% of automated test runs on supported devices.
- **SC-004**: No more than 2% of rounds exhibit missing assets or duplicate options during a 100-round automated regression run.
