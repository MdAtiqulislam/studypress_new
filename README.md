# StudyPress (studypress_new)

A Flutter education app (new iteration) — learning content, courses and exam preparation with a modular MVC-style codebase.

## Features

- Course browsing and learning flows
- Auth and user profile management
- Modular views with shared controllers, models and services
- Utilities and constraints for consistent UI

## Tech Stack

- Flutter (Dart)
- GetX-style controllers with modular views
- REST API backend

## Getting Started

```bash
flutter pub get
flutter run
```

Build a release APK:

```bash
flutter build apk --release
```

## Project Structure

```
lib/
├── views/        # Feature screens
├── controllers/  # Business logic
├── models/       # Data models
├── services/     # API and platform services
├── utilities/    # Helpers
└── main.dart     # App entry point
```

## Notes

- App label: "StudyPress" (Android), title "StudyPress"
- No secrets or keystores are committed to this repository.
