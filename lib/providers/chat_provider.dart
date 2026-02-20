import 'package:flutter/foundation.dart';

import '../models/chat_message.dart';
import '../services/ai_service.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider(this._aiService);

  final AIService _aiService;

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _patternSuggestion;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get patternSuggestion => _patternSuggestion;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    _messages.add(ChatMessage(text: text.trim(), isUser: true, timestamp: DateTime.now()));
    _isLoading = true;
    _detectOverthinkingPattern();
    notifyListeners();

    final response = await _aiService.getAIResponse(text.trim());

    _messages.add(ChatMessage(text: response, isUser: false, timestamp: DateTime.now()));
    _isLoading = false;
    notifyListeners();
  }

  void _detectOverthinkingPattern() {
    final userMessages = _messages.where((m) => m.isUser).toList();
    if (userMessages.length < 3) {
      _patternSuggestion = null;
      return;
    }

    final recent = userMessages.reversed.take(3).map((m) => m.text.toLowerCase()).toList();
    final isSimilarNegative = recent.every((m) => m.contains('stress') || m.contains('anxiety') || m.contains('worried') || m.contains('overthinking') || m.contains('alone'));

    _patternSuggestion = isSimilarNegative
        ? 'I notice a repeating stress pattern. Want to try a 2-minute grounding task before we continue?'
        : null;
  }
}
