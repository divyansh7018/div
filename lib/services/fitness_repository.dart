import '../models/meal.dart';
import '../models/workout.dart';

class FitnessRepository {
  List<WorkoutDay> workouts() {
    const base = [
      Exercise(name: 'Push Ups', image: 'assets/svg/dumbbell.svg', instructions: 'Keep a straight body line, lower under control, and press through the palms.', sets: 4, reps: '10-15', restSeconds: 60, difficulty: 'Beginner', targetMuscles: ['Chest', 'Triceps', 'Core'], animation: 'Controlled press'),
      Exercise(name: 'Dumbbell Row', image: 'assets/svg/dumbbell.svg', instructions: 'Hinge at hips, pull elbow toward waist, pause, and lower slowly.', sets: 4, reps: '12 each', restSeconds: 75, difficulty: 'Beginner', targetMuscles: ['Back', 'Biceps'], animation: 'Pull and squeeze'),
      Exercise(name: 'Squat', image: 'assets/svg/dumbbell.svg', instructions: 'Brace core, sit hips down and back, keep knees tracking toes.', sets: 4, reps: '12-15', restSeconds: 90, difficulty: 'Beginner', targetMuscles: ['Quads', 'Glutes'], animation: 'Smooth depth'),
      Exercise(name: 'Plank', image: 'assets/svg/dumbbell.svg', instructions: 'Stack elbows under shoulders and hold ribs down without sagging.', sets: 3, reps: '45 sec', restSeconds: 45, difficulty: 'Beginner', targetMuscles: ['Abs', 'Core'], animation: 'Static hold'),
    ];
    return const [
      WorkoutDay(day: 'Monday', title: 'Chest + Triceps', exercises: base),
      WorkoutDay(day: 'Tuesday', title: 'Back + Biceps', exercises: base),
      WorkoutDay(day: 'Wednesday', title: 'Legs', exercises: base),
      WorkoutDay(day: 'Thursday', title: 'Shoulders', exercises: base),
      WorkoutDay(day: 'Friday', title: 'Upper Body', exercises: base),
      WorkoutDay(day: 'Saturday', title: 'Arms + Abs', exercises: base),
      WorkoutDay(day: 'Sunday', title: 'Rest', exercises: []),
    ];
  }
  List<Meal> meals() => const [
    Meal(name: 'Breakfast', items: ['Eggs', 'Oats', 'Bananas', 'Milk'], calories: 720, protein: 35, carbs: 92, fat: 22, time: '8:00 AM'),
    Meal(name: 'Lunch', items: ['Rice', 'Dal', 'Soy Chunks', 'Vegetables', 'Curd'], calories: 890, protein: 48, carbs: 126, fat: 18, time: '1:00 PM'),
    Meal(name: 'Evening', items: ['Banana Shake', 'Peanuts'], calories: 520, protein: 22, carbs: 58, fat: 23, time: '5:00 PM'),
    Meal(name: 'Dinner', items: ['Rice', 'Paneer', 'Vegetables'], calories: 760, protein: 36, carbs: 88, fat: 28, time: '8:30 PM'),
    Meal(name: 'Before Bed', items: ['Milk'], calories: 160, protein: 9, carbs: 12, fat: 8, time: '10:30 PM'),
  ];
}
