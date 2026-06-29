class Exercise {
  const Exercise({required this.name, required this.image, required this.instructions, required this.sets, required this.reps, required this.restSeconds, required this.difficulty, required this.targetMuscles, required this.animation});
  final String name, image, instructions, reps, difficulty, animation;
  final int sets, restSeconds;
  final List<String> targetMuscles;
}

class WorkoutDay {
  const WorkoutDay({required this.day, required this.title, required this.exercises});
  final String day, title;
  final List<Exercise> exercises;
}
