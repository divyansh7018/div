import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class AIService {
  AIService({
    String? apiKey,
    String? baseUrl,
    http.Client? client,
  })  : _apiKey = apiKey ?? const String.fromEnvironment('OPENAI_API_KEY'),
        _baseUrl = baseUrl ?? const String.fromEnvironment('OPENAI_BASE_URL', defaultValue: 'https://api.openai.com/v1'),
        _client = client ?? http.Client();

  final String _apiKey;
  final String _baseUrl;
  final http.Client _client;

  Future<String> getAIResponse(String userMessage) async {
    if (_apiKey.isEmpty) return _fallbackResponse(userMessage);

    try {
      final response = await _client
          .post(
            Uri.parse('$_baseUrl/chat/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: jsonEncode({
              'model': 'gpt-4o-mini',
              'messages': [
                {
                  'role': 'system',
                  'content':
                      'You are a supportive CBT-style mental wellness assistant for youth. Reply in exactly 3 short sections: Emotion Validation, Reframing, Actionable Step.',
                },
                {'role': 'user', 'content': userMessage},
              ],
              'temperature': 0.7,
            }),
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return _fallbackResponse(userMessage);
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      final choices = decoded['choices'];
      if (choices is! List || choices.isEmpty) return _fallbackResponse(userMessage);

      final first = choices.first;
      if (first is! Map<String, dynamic>) return _fallbackResponse(userMessage);
      final message = first['message'];
      if (message is! Map<String, dynamic>) return _fallbackResponse(userMessage);

      final content = message['content']?.toString().trim();
      return (content == null || content.isEmpty) ? _fallbackResponse(userMessage) : content;
    } catch (_) {
      return _fallbackResponse(userMessage);
    }
  }

  String _fallbackResponse(String userMessage) {
    return '🌿 Emotion Validation: It makes sense you feel this way. Your feelings matter.\n\n'
        '🧠 Gentle Reframe: This moment is hard, but it is temporary and you still have strengths.\n\n'
        '✅ Actionable Step: Do 2 minutes of slow breathing, then write one kind thought about "$userMessage".';
  }
}
