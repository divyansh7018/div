import 'dart:convert';

import 'package:http/http.dart' as http;

class AIService {
  AIService({String? apiKey}) : _apiKey = apiKey ?? const String.fromEnvironment('OPENAI_API_KEY');

  final String _apiKey;

  Future<String> getAIResponse(String userMessage) async {
    if (_apiKey.isEmpty) {
      return _fallbackResponse(userMessage);
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-4o-mini',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a supportive CBT-style mental wellness assistant for youth. Keep responses concise, kind, and actionable in 3 sections: Emotion validation, Reframing, Small actionable step.',
            },
            {'role': 'user', 'content': userMessage},
          ],
          'temperature': 0.7,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final choices = decoded['choices'] as List<dynamic>?;
        final content = choices?.firstOrNull?['message']?['content']?.toString();
        if (content != null && content.trim().isNotEmpty) {
          return content.trim();
        }
      }
      return _fallbackResponse(userMessage);
    } catch (_) {
      return _fallbackResponse(userMessage);
    }
  }

  String _fallbackResponse(String userMessage) {
    return '🌿 Emotion Validation: It makes sense you feel this way. Your feelings matter.\n\n'
        '🧠 Gentle Reframe: This moment is difficult, but it does not define your future.\n\n'
        '✅ Actionable Step: Do 2 minutes of slow breathing, then write one kind thought about "$userMessage".';
  }
}

extension on List<dynamic> {
  dynamic get firstOrNull => isEmpty ? null : first;
}
