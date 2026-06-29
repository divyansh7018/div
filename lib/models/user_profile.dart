class UserProfile {
  const UserProfile({required this.name, required this.age, required this.heightCm, required this.currentWeightKg, required this.goalWeightKg, required this.goal, required this.experience});
  final String name;
  final int age;
  final double heightCm;
  final double currentWeightKg;
  final double goalWeightKg;
  final String goal;
  final String experience;
  factory UserProfile.defaultProfile() => const UserProfile(name: 'Lucky', age: 25, heightCm: 173, currentWeightKg: 53, goalWeightKg: 62, goal: 'Muscle Gain', experience: 'Beginner');
  Map<String, dynamic> toMap() => {'name': name, 'age': age, 'heightCm': heightCm, 'currentWeightKg': currentWeightKg, 'goalWeightKg': goalWeightKg, 'goal': goal, 'experience': experience};
  factory UserProfile.fromMap(Map map) => UserProfile(name: map['name'] ?? 'Lucky', age: map['age'] ?? 25, heightCm: (map['heightCm'] ?? 173).toDouble(), currentWeightKg: (map['currentWeightKg'] ?? 53).toDouble(), goalWeightKg: (map['goalWeightKg'] ?? 62).toDouble(), goal: map['goal'] ?? 'Muscle Gain', experience: map['experience'] ?? 'Beginner');
  UserProfile copyWith({String? name, int? age, double? heightCm, double? currentWeightKg, double? goalWeightKg, String? goal, String? experience}) => UserProfile(name: name ?? this.name, age: age ?? this.age, heightCm: heightCm ?? this.heightCm, currentWeightKg: currentWeightKg ?? this.currentWeightKg, goalWeightKg: goalWeightKg ?? this.goalWeightKg, goal: goal ?? this.goal, experience: experience ?? this.experience);
}
