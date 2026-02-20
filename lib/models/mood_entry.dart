class MoodEntry {
  MoodEntry({required this.emoji, required this.score, required this.date});

  final String emoji;
  final int score;
  final DateTime date;

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'score': score,
        'date': date.toIso8601String(),
      };

  factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
        emoji: json['emoji'] as String,
        score: json['score'] as int,
        date: DateTime.parse(json['date'] as String),
      );
}
