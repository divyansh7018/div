class Meal {
  const Meal({required this.name, required this.items, required this.calories, required this.protein, required this.carbs, required this.fat, required this.time});
  final String name, time;
  final List<String> items;
  final int calories;
  final double protein, carbs, fat;
}
