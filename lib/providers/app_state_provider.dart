import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/achievement.dart';
import '../models/progress_entry.dart';
import '../models/user_profile.dart';
import '../services/local_storage_service.dart';
import '../utils/calculators.dart';

class AppStateProvider extends ChangeNotifier {
  AppStateProvider(this.storage);
  final LocalStorageService storage;
  UserProfile profile = UserProfile.defaultProfile();
  int waterGlasses = 0, calories = 0;
  double protein = 0;
  bool darkMode = true;
  final Set<String> completedWorkouts = {}, completedMeals = {};
  List<ProgressEntry> history = [];
  int workoutStreak = 6;
  Future<void> init() async {
    profile = UserProfile.fromMap(storage.get('profile', profile.toMap()));
    waterGlasses = storage.get('water', 4); calories = storage.get('calories', 1840); protein = storage.get('protein', 86.0);
    completedWorkouts.addAll(List<String>.from(storage.get('workouts', <String>[]))); completedMeals.addAll(List<String>.from(storage.get('meals', <String>[])));
    history = List<Map>.from(storage.get('history', _seedHistory().map((e) => e.toMap()).toList())).map(ProgressEntry.fromMap).toList();
  }
  double get bmi => FitnessCalculators.bmi(profile.currentWeightKg, profile.heightCm);
  double get bmr => FitnessCalculators.bmr(kg: profile.currentWeightKg, cm: profile.heightCm, age: profile.age);
  double get bodyFat => FitnessCalculators.bodyFatEstimate(bmi: bmi, age: profile.age);
  String get quote => AppConstants.quotes[DateTime.now().day % AppConstants.quotes.length];
  void toggleWorkout(String id) { completedWorkouts.contains(id) ? completedWorkouts.remove(id) : completedWorkouts.add(id); storage.put('workouts', completedWorkouts.toList()); notifyListeners(); }
  void toggleMeal(String id) { completedMeals.contains(id) ? completedMeals.remove(id) : completedMeals.add(id); storage.put('meals', completedMeals.toList()); notifyListeners(); }
  void addWater() { waterGlasses = min(12, waterGlasses + 1); storage.put('water', waterGlasses); notifyListeners(); }
  void updateTrackers({int? caloriesValue, double? proteinValue}) { calories = caloriesValue ?? calories; protein = proteinValue ?? protein; storage.put('calories', calories); storage.put('protein', protein); notifyListeners(); }
  Future<void> updateProfile(UserProfile value) async { profile = value; await storage.put('profile', value.toMap()); notifyListeners(); }
  Future<void> resetProgress() async { await storage.clear(); completedMeals.clear(); completedWorkouts.clear(); waterGlasses = 0; calories = 0; protein = 0; history = _seedHistory(); profile = UserProfile.defaultProfile(); notifyListeners(); }
  List<Achievement> achievements() => [Achievement('7 Day Streak', 'Train for seven days.', '🔥', workoutStreak >= 7), Achievement('30 Day Streak', 'Build a month of consistency.', '🏆', workoutStreak >= 30), Achievement('90 Day Challenge', 'Complete LuckyFit 90.', '👑', workoutStreak >= 90), Achievement('Workout Master', 'Finish every workout today.', '💪', completedWorkouts.length >= 4), Achievement('Protein Goal', 'Hit 110g protein.', '🥚', protein >= 110), Achievement('Water Goal', 'Drink 8 glasses.', '💧', waterGlasses >= 8)];
  List<ProgressEntry> _seedHistory() => List.generate(8, (i) { final w = 53 + i * .55; return ProgressEntry(date: DateTime.now().subtract(Duration(days: (7 - i) * 7)), weight: w, chest: 86 + i * .4, arms: 28 + i * .25, waist: 74 - i * .2, legs: 48 + i * .35, bmi: FitnessCalculators.bmi(w, 173)); });
}
