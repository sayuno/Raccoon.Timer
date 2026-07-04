# Raccoon Timer

Mobile routine/agenda app — countdown timers, recurring alarms, and per-routine
music. Flutter (Android first; iOS later).

Create named routines with a type, a schedule, and a sound. The app wakes you
with a full-screen alarm and plays the routine's song.

## Schedule modes
- **Daily** — fixed clock time every day (standard alarm), optional weekday filter.
- **Interval** — every X hours / Y minutes, optional active window + weekdays.
- **One-shot** — a single date/time, then auto-pauses.

## Sound sources
- **Default alarm** — bundled tone (`assets/sounds/`).
- **Local** — a song file picked from the phone.
- **Spotify** — connect once in Settings (OAuth), then routines pick a track.
  *(Playback via the Spotify App Remote SDK is a later slice; requires Premium.)*

## Stack
- **Flutter / Dart**
- **drift** (SQLite) — local persistence, offline
- **flutter_riverpod** — state
- **flutter_local_notifications** + **android_alarm_manager_plus** — exact alarms
- **just_audio** — local / bundled playback
- **file_picker** — pick a local song
- **flutter_secure_storage** — Spotify token (never in the DB)

## Project layout
```
lib/
  main.dart, app.dart
  theme/app_theme.dart          palette (dark, cyan/gold)
  core/
    schedule.dart               pure next-trigger computation
    time_utils.dart             countdown / clock / summary formatting
  data/
    database.dart               drift tables + seeds + DAO
    providers.dart              riverpod providers + RoutineRepository
  services/
    notification_service.dart   exact full-screen alarms
    audio_service.dart          play/stop the routine sound
  features/
    home/                       dashboard + routine cards
    routine_editor/             create/edit + new_type_sheet (inline type)
    routine_detail/             countdown + history
    fire/                       full-screen alarm
    settings/                   theme, defaults, Spotify connect, permissions
```

## Setup
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # generates database.g.dart
flutter run
```

> Add at least one tone at `assets/sounds/alarm1.mp3` for the default alarm
> (declared in `pubspec.yaml`). Local + Spotify sounds don't need it.

## TODO (next slices)
- [ ] Reschedule OS alarms after each save/fire/boot (wire NotificationService.scheduleNext).
- [ ] Spotify App Remote playback (Settings OAuth -> track search in editor).
- [ ] Prune trigger logs > 30 days on app start.
- [ ] iOS support (background music is limited — see requirements FR-C3).
- [ ] Bundle default alarm tones.

Design & requirements: see `RaccoonAI/.harness/Raccoon.TimerApp/`.
