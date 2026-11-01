# SpeakLocal

SpeakLocal is a Flutter Android app for English practice. It includes lesson practice, local progress, placement testing, learning history, an adaptive offline vocabulary tutor, and a dedicated text/voice Smart Tutor chat interface.

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

## Smart Tutor chat backend

The Smart Tutor chat tab is a client for a separately hosted backend. It does not pretend to be an AI when no backend is configured.

Set the endpoint at build time:

```bash
flutter build apk --debug \
  --dart-define=SPEAKLOCAL_TUTOR_API_URL=https://YOUR_DOMAIN/api/tutor/chat
```

The endpoint must accept an HTTP POST with JSON:

```json
{
  "message": "I went to school yesterday.",
  "history": [
    {"role": "user", "content": "Hello!"},
    {"role": "assistant", "content": "Hello! How can I help you practice?"}
  ],
  "language": "en",
  "mode": "english_tutor"
}
```

Return JSON containing a non-empty `reply` string:

```json
{"reply":"Good sentence! Remember to use the past form 'went' for yesterday."}
```

The backend should:
- Keep model-provider API keys on the server, never in the mobile app.
- Validate and limit message/history sizes.
- Apply rate limits and appropriate content-safety controls.
- Avoid retaining conversation data unless the user has been informed and the retention is necessary.
- Return useful HTTP error codes and JSON responses.

The mobile chat currently stores the conversation locally in SharedPreferences. Voice input uses Android speech recognition; assistant replies can be read aloud using Android text-to-speech. Speech recognition availability depends on the device and installed speech services.

## Current learning components

- Lesson practice and progress: `ProgressService`.
- Learning corrections and vocabulary memory: `LearningMemoryService`.
- Practice analytics: `PracticeAnalyticsService`.
- Adaptive vocabulary/slang content: `TutorContentBank`, `TutorLearnerProfile`, and `SmartTutorEngine`.
- Smart Tutor conversation UI: `TutorChatScreen`.
- Chat transport: `TutorChatService`.

## Important evaluation note

The existing pronunciation score compares recognized text with the target phrase. It is a transcript similarity estimate, not acoustic phoneme-level pronunciation assessment.

## USB troubleshooting

```bash
adb kill-server
adb start-server
adb devices
```

Accept the USB debugging authorization prompt on the phone. If the device is listed as unauthorized, reconnect the cable and approve the prompt.
