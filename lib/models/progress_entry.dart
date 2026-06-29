class ProgressEntry {
  const ProgressEntry({required this.date, required this.weight, required this.chest, required this.arms, required this.waist, required this.legs, required this.bmi});
  final DateTime date;
  final double weight, chest, arms, waist, legs, bmi;
  Map<String, dynamic> toMap() => {'date': date.toIso8601String(), 'weight': weight, 'chest': chest, 'arms': arms, 'waist': waist, 'legs': legs, 'bmi': bmi};
  factory ProgressEntry.fromMap(Map map) => ProgressEntry(date: DateTime.parse(map['date']), weight: (map['weight'] ?? 0).toDouble(), chest: (map['chest'] ?? 0).toDouble(), arms: (map['arms'] ?? 0).toDouble(), waist: (map['waist'] ?? 0).toDouble(), legs: (map['legs'] ?? 0).toDouble(), bmi: (map['bmi'] ?? 0).toDouble());
}
