import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../core/constants/app_constants.dart';
import '../models/micro_task.dart';
import '../services/local_storage_service.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider(this._storageService);

  final LocalStorageService _storageService;

  List<MicroTask> _tasks = [];
  int _streak = 0;

  List<MicroTask> get tasks => List.unmodifiable(_tasks);
  int get streak => _streak;
  bool get allDone => _tasks.isNotEmpty && _tasks.every((task) => task.isCompleted);

  Future<void> init() async {
    _streak = await _storageService.readInt(AppConstants.streakStorageKey);
    final lastSavedDate = await _storageService.readString(AppConstants.lastTaskCompletionDateKey);
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final data = await _storageService.readJsonList(AppConstants.taskStorageKey);
    if (data.isEmpty || lastSavedDate != today) {
      _tasks = _generateDailyTasks();
      await _saveTasks();
    } else {
      _tasks = data.map(MicroTask.fromJson).toList();
    }
    notifyListeners();
  }

  List<MicroTask> _generateDailyTasks() => [
        MicroTask(id: '1', title: 'Take 5 deep breaths mindfully.'),
        MicroTask(id: '2', title: 'Drink a glass of water and stretch for 2 minutes.'),
        MicroTask(id: '3', title: 'Write one gratitude line in your mind.'),
      ];

  Future<void> toggleTask(MicroTask task, bool? value) async {
    task.isCompleted = value ?? false;

    if (allDone) {
      final today = DateTime.now();
      final todayStr = DateFormat('yyyy-MM-dd').format(today);
      final lastDate = await _storageService.readString(AppConstants.lastTaskCompletionDateKey);

      if (lastDate != todayStr) {
        _streak += 1;
        await _storageService.saveInt(AppConstants.streakStorageKey, _streak);
        await _storageService.saveString(AppConstants.lastTaskCompletionDateKey, todayStr);
      }
    }

    await _saveTasks();
    notifyListeners();
  }

  Future<void> _saveTasks() async {
    await _storageService.saveJsonList(AppConstants.taskStorageKey, _tasks.map((e) => e.toJson()).toList());
  }
}
