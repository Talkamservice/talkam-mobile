// The two `onboarding.userType` values the backend understands — shared so
// UserTypeSelectionScreen (which sets it) and DataPrivacyScreen (which reads
// it to decide whether to route into the therapist wizard) can't drift apart.
const String kSupportSeekerUserType = "support_seeker";
const String kMentalHealthProUserType = "mental_health_pro";
