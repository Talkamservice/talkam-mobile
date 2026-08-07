# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**The app will not work without `--dart-define-from-file`.** Every base URL, API key, and third-party secret comes from `String.fromEnvironment` in `lib/core/services/network/url_config.dart`. Omitting the flag silently yields empty strings, so requests go to `""` and fail in confusing ways.

```bash
flutter run --dart-define-from-file=config.json          # dev
flutter run --dart-define-from-file=prod_config.json     # prod values
flutter analyze
flutter test
flutter test test/widget_test.dart --plain-name "name"   # single test / by name
```

`config.json` and `prod_config.json` are gitignored; `config.example.json` / `prod_config.example.json` are the templates. VSCode launch configs in `.vscode/launch.json` already pass the flag.

Codegen (freezed states, `Assets` class). `.freezed.dart` files are committed, so this is only needed after editing a freezed class or adding an asset:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Assets must also be declared under `flutter.assets` in `pubspec.yaml` — `flutter_gen` outputs `lib/gen/assets.gen.dart` from those directory entries.

## Architecture

### Startup chain

`lib/main.dart` → `Hive.initFlutter()` → `AppConfig.run('Talkam', Environment.development)` → `AppConfig._setup()`:

1. `di.init()` — registers four GetIt modules in order: network, repository, bloc, service (`lib/core/di/`). Order matters; repositories take `NetworkService` via `getIt.get()`.
2. `_initializeServices()` — Firebase, Remote Config, notifications, `SessionManager().init()`, Timezone, Pusher, Shorebird update check, portrait lock.
3. `runApp(TalkAmApp())` inside `runZonedGuarded`.

Note `main.dart` hardcodes `Environment.development`. `UrlConfig.environment` is a separate static that also defaults to development and selects between the `PROD_*`/`DEV_*` defines — changing environment means changing both.

### Widget tree root

`lib/app.dart` wraps everything in `ScreenUtilInit(designSize: Size(390, 852))` → `OverlaySupport.global` → `BaseBlocProvider` → `PushNotificationListener` → `MaterialApp.router`. The design size is why sizing uses `.w`/`.h`/`.sp` everywhere.

`BaseBlocProvider` provides `DrawerCubit` locally and rebuilds the whole app on `ProfileBloc` state changes (bloc pulled from `injector`, not provided).

### Feature layout

`lib/features/<feature>/` with `data/{models,repository}`, `dormain/{repository,models,mixins}`, `presentation/{bloc|blocs,screens,widgets,tabs}`.

**`dormain` is the spelling used throughout** (11 directories, zero named `domain`). Match it — a correctly-spelled `domain/` directory will break imports and look out of place.

Blocs live under `bloc/` in some features and `blocs/` in others; follow whatever the feature already uses.

### State management

`flutter_bloc` with both `Bloc` and `Cubit`. States are `freezed` unions consumed via `state.maybeWhen(...)` / `state.when(...)`.

Two registration styles coexist and both are in active use:

- **Global singletons in GetIt** (`lib/core/di/bloc_module.dart`) — most blocs, reached with `injector.get<XCubit>()` or `BlocBuilder(bloc: injector.get(), ...)`. These survive navigation and hold state across screens.
- **Locally constructed** — screen-scoped blocs created in the screen or passed through `GoRoute`'s `state.extra` (the therapist application flow does this: `TherapistApplicationBloc` is built once and handed to each step screen).

`ProfileCommentTabCubit` is the only `registerFactory`; everything else is `registerLazySingleton`.

### Networking

`NetworkService` (`lib/core/services/network/network_service.dart`) wraps Dio with a single `call(path, RequestMethod, {...})` method. It injects the bearer token from `SessionManager.instance.authToken` and a `timezone` header per request, reports failures to Sentry, and converts errors into `ApiError` via `Future.error`. Repositories catch/rethrow; there is no `Either` wrapper in practice despite `either_dart` being a dependency.

All endpoint paths are string constants on `UrlConfig` — add new ones there rather than inlining URLs.

### Routing

`go_router`, configured in `lib/core/navigation/routes.dart`, route **names** in `lib/core/navigation/route_url.dart` (`PageUrl`), query-param keys in `path_params.dart`. Navigate by name (`context.pushNamed(PageUrl.x)`), not by literal path.

A `StatefulShellRoute` drives the main app. Branch indices are declared as private constants in `lib/features/home/presentation/screens/base_page.dart` (`_kHomeBranch` 0, `_kGroupsBranch` 1, `_kWellnessBranch` 2, `_kCalendarBranch` 3, `_kEarningsBranch` 4, `_kProfileBranch` 5). **Adding or reordering a branch in `routes.dart` requires updating those constants** — they are positional and nothing enforces the link. Search and Groups are real branches not shown in the bottom bar; Messaging is a top-level route outside the shell entirely.

A top-level `redirect` (`_requireAliasForGuests`) bounces guests without an alias out of the shell tabs to `/anonymousSignInScreen`. Guard guest actions in UI with `GuestUserHelper.handleGuestUserAction`.

### Therapist mode

`SessionManager.instance.isTherapistAccount` is a **device-local `SharedPreferences` bool**, not a server field. `TalkamUser.role` exists but nothing populates it. The earnings tab and other therapist affordances key off this flag. Expect it to be replaced by a real account-type field later — keep role checks funnelled through `SessionManager` rather than scattering local storage reads.

Therapist surfaces are currently split across several features: `features/authentication/presentation/screens/therapist/` (the multi-step application/onboarding flow), `features/therapist_application/` (its bloc + payload model), `features/therapist/` (patient-facing therapist list, profile, and booking flow), `features/session/`, `features/calendar/`, and `features/earnings/`.

### Mock data

`lib/core/mock/mock_home_data.dart` is referenced by ~27 files. As its own doc comment states, it is **deliberately unconditional** — screens render `MockHomeData` instead of the API response while staging has no seed data. When touching a screen that reads from it, check whether you are meant to be wiring real data or extending the mock, and don't assume a bloc's loaded state is what reaches the UI.

## UI conventions

- **Text**: use the shared `TextView` widget (`lib/common/widgets/text_view.dart`), not raw `Text`. It defaults to `GoogleFonts.nunito` at `15.sp`. Note the app theme's `fontFamily` is Plus Jakarta Sans, so anything going through `Theme.of(context).textTheme` renders in a different face than `TextView` — this is existing, intentional-looking divergence.
- **Colors**: `Pallets` (`lib/core/theme/pallets.dart`) — a flat `abstract class` of `static const Color`. Add new colors there; do not inline hex.
- **Sizing**: `.w` / `.h` / `.sp` from `flutter_screenutil` against the 390×852 design size.
- **Assets**: `Assets.images.svgV2.*` etc. from `lib/gen/assets.gen.dart`. `svg_v2/` holds the newer icon set; `svgs/` is the older one.
- **Theme**: `AppTheme.lightTheme` with `useMaterial3: false`. `darkTheme` exists but nothing switches to it — the app is light-only in practice.
- `lib/core/constants/package_exports.dart` is a barrel re-exporting `flutter_screenutil` and `go_router`; many files import it instead of those packages directly.

## Other notes

- Localization is scaffolded but dormant: `lib/generated/l10n.dart` and `lib/l10n/intl_en.arb` exist, `flutter_intl` is enabled in `pubspec.yaml`, but `localization_extension.dart` is entirely commented out and `MaterialApp` registers no `S.delegate`. Strings are hardcoded.
- `test/` contains only the default `widget_test.dart` placeholder. There is no established test pattern to follow.
- Lints are stock `flutter_lints` with no project rules added.
- `analyze_errors.txt` / `analyze_errors2.txt` are stale scratch output, not a maintained baseline.
- `todo` (root, extensionless) tracks three outstanding items: refactor post details page, refactor chat screen, move hardcoded URLs to Remote Config.
