import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../services/fitness_repository.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/meal_card.dart';
class DietScreen extends StatelessWidget { const DietScreen({super.key}); @override Widget build(BuildContext context) { final app = context.watch<AppStateProvider>(); final meals = FitnessRepository().meals(); final totalCalories = meals.fold<int>(0, (p, e) => p + e.calories); final totalProtein = meals.fold<double>(0, (p, e) => p + e.protein); return Scaffold(appBar: const CustomAppBar(title: 'Diet Plan', subtitle: 'Budget ₹3000/month'), body: ListView(padding: const EdgeInsets.all(16), children: [Card(child: ListTile(leading: const Icon(Icons.savings, color: Colors.amber), title: const Text('Lean Muscle Budget Plan'), subtitle: Text('$totalCalories kcal • ${totalProtein.toStringAsFixed(0)}g protein • offline meal checklist'))), ...meals.map((m) => MealCard(meal: m, completed: app.completedMeals.contains(m.name), onChanged: (_) => app.toggleMeal(m.name))), const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('Supplements: Creatine 5g daily • Whey Protein 1 scoop • Omega 3 with dinner. Reminder notifications are available from Profile.')))])); } }
