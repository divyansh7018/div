import 'package:flutter/foundation.dart';

import '../core/constants/app_constants.dart';
import '../models/mood_entry.dart';
import '../services/local_storage_service.dart';

class MoodProvider extends ChangeNotifier {
  MoodProvider(this._storageService);

  final LocalStorageService _storageService;

  final List<MoodEntry> _moodHistory = [];
  MoodEntry? _todayMood;

  List<MoodEntry> get moodHistory => List.unmodifiable(_moodHistory);
  MoodEntry? get todayMood => _todayMood;

  Future<void> init() async {
    final data = await _storageService.readJsonList(AppConstants.moodStorageKey);
    _moodHistory
      ..clear()
      ..addAll(data.map(MoodEntry.fromJson));

    final today = DateTime.now();
    _todayMood = _moodHistory.where((e) => e.date.year == today.year && e.date.month == today.month && e.date.day == today.day).cast<MoodEntry?>().firstOrNull;
    notifyListeners();
  }

  Future<void> saveMood(String emoji, int score) async {
    final entry = MoodEntry(emoji: emoji, score: score, date: DateTime.now());
    _todayMood = entry;

    _moodHistory.removeWhere((e) => e.date.year == entry.date.year && e.date.month == entry.date.month && e.date.day == entry.date.day);
    _moodHistory.add(entry);
    _moodHistory.sort((a, b) => a.date.compareTo(b.date));

    await _storageService.saveJsonList(AppConstants.moodStorageKey, _moodHistory.map((e) => e.toJson()).toList());
    notifyListeners();
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
