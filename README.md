# MindMitra

AI-powered mental wellness support app for youth built with Flutter + Provider.

## Setup
1. Install Flutter stable and run `flutter pub get`.
2. Configure Firebase for Android/iOS and add platform config files (`google-services.json` / `GoogleService-Info.plist`).
3. Enable Email/Password auth and Firestore in Firebase console.
4. Run with OpenAI API key:

```bash
flutter run --dart-define=OPENAI_API_KEY=your_key_here
```
