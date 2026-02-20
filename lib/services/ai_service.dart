class AIService {
  Future<String> getAIResponse(String userMessage) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));

    return '🌿 Emotion Validation: It makes sense you feel this way. What you are facing is real and important.\n\n'
        '🧠 Gentle Reframe: This moment does not define your whole journey. You can take one small step and still make meaningful progress.\n\n'
        '✅ Actionable Step: Try a 4-4-6 breathing cycle for 2 minutes, then write one kind sentence to yourself about "$userMessage".';
  }
}
