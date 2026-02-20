class MicroTask {
  MicroTask({required this.id, required this.title, this.isCompleted = false});

  final String id;
  final String title;
  bool isCompleted;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  factory MicroTask.fromJson(Map<String, dynamic> json) => MicroTask(
        id: json['id'] as String,
        title: json['title'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );
}
