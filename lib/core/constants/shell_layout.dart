/// `BasePage`'s bottom nav bar (`lib/features/home/presentation/screens/
/// base_page.dart`) is a `Scaffold.bottomNavigationBar`, but that `Scaffold`
/// also sets `extendBody: true` — so each branch screen's body renders full
/// height *behind* the bar, and only gets the reserved space back if it
/// explicitly consumes `MediaQuery.padding.bottom` (via `SafeArea`) or adds
/// its own matching bottom padding. Screens that do neither render their
/// last content underneath the floating nav bar.
///
/// This is that bar's real height (48.h icon + 10.h padding top and bottom +
/// 1px border), so every branch screen's scroll content can reserve the same
/// amount instead of guessing or duplicating the number.
const double kShellNavBarHeight = 69;
