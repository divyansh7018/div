import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../core/constants/app_constants.dart';
import '../models/journal_entry.dart';
import '../services/local_storage_service.dart';

class JournalProvider extends ChangeNotifier {
  JournalProvider(this._storageService);

  final LocalStorageService _storageService;
  final _uuid = const Uuid();

  final List<JournalEntry> _entries = [];
  List<JournalEntry> get entries => List.unmodifiable(_entries);

  Future<void> init() async {
    final data = await _storageService.readJsonList(AppConstants.journalStorageKey);
    _entries
      ..clear()
      ..addAll(data.map(JournalEntry.fromJson));
    _entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    notifyListeners();
  }

  Future<void> addEntry(String text) async {
    _entries.insert(0, JournalEntry(id: _uuid.v4(), content: text.trim(), createdAt: DateTime.now()));
    await _persist();
    notifyListeners();
  }

  Future<void> deleteEntry(String id) async {
    _entries.removeWhere((entry) => entry.id == id);
    await _persist();
    notifyListeners();
  }

  Future<void> _persist() async {
    await _storageService.saveJsonList(AppConstants.journalStorageKey, _entries.map((e) => e.toJson()).toList());
  }
}
