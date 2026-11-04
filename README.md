# SpeakLocal

SpeakLocal is an offline-first Flutter Android app for English practice. The app focuses on structured lessons, speaking practice, local progress tracking, placement testing, learning history, and practice analytics. It does not include a Smart Tutor chat, AI tutor backend, Firebase integration, or account-based cloud services.

## Requirements

- Flutter SDK compatible with the constraint in `pubspec.yaml` (Dart 3.5.4 or later).
- Android SDK and platform tools.
- USB debugging enabled for device installation.
- An Android speech-recognition service and English speech pack for speech input. Text-to-speech uses the Android TTS engine.

## Get the project

```bash
git clone https://github.com/Ahmed887v/2547-.git
cd 2547-
flutter pub get
```

If you already have a local clone:

```bash
git switch main
git pull --ff-only origin main
flutter pub get
```

## Analyze, test and build

```bash
flutter analyze
flutter test
flutter build apk --debug
```

Install the debug APK over USB:

```bash
adb devices
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

Build a release APK or Play Store bundle:

```bash
flutter build apk --release
flutter build appbundle --release
```

Release signing must be configured locally. Never commit keystore files, passwords, or `key.properties`.

## Current learning components

- Lesson practice and progress: `ProgressService`.
- Learning corrections and vocabulary memory: `LearningMemoryService`.
- Practice analytics: `PracticeAnalyticsService`.
- Speech input and on-device text-to-speech.
- Placement testing, learning history, and progress reporting.

## Important evaluation note

The existing pronunciation score compares recognized text with the target phrase. It is a transcript similarity estimate, not acoustic phoneme-level pronunciation assessment.

## USB troubleshooting

```bash
adb kill-server
adb start-server
adb devices
```

Accept the USB debugging authorization prompt on the phone. If the device is listed as unauthorized, reconnect the cable and approve the prompt.
