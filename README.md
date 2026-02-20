# MindMitra

AI-powered mental wellness support app for youth built with Flutter + Provider.

## Setup
1. Install Flutter stable and run `flutter pub get`.
2. Configure Firebase for Android/iOS and add platform config files (`google-services.json` / `GoogleService-Info.plist`).
3. Enable Email/Password auth and Firestore in Firebase console.
4. Run with OpenAI API key (and optional proxy/base URL):

```bash
flutter run \
  --dart-define=OPENAI_API_KEY=your_key_here \
  --dart-define=OPENAI_BASE_URL=https://api.openai.com/v1
```

## Notes
- If Firebase configuration is missing, the app still launches but auth/backend features will not work until platform configs are added.
- Onboarding is shown once per device and then persisted locally.
