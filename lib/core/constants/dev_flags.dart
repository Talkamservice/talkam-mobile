/// Temporary development switches.
///
/// Everything here MUST be `false` before release — these bypass real product
/// behaviour and exist only to unblock local testing.
library;

/// Skips the "user must have interests" onboarding gate.
///
/// The gate sends any logged-in user with no saved interests to the interests
/// screen on every launch. While `/user/post-categories` returns nothing, that
/// screen can't be satisfied (its ids are rejected with a 422), so the app
/// loops there forever and the screens after it are unreachable.
///
/// Set back to `false` once the categories endpoint returns real data.
const bool kSkipInterestsGate = false;
