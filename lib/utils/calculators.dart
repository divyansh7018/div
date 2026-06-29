class FitnessCalculators {
  static double bmi(double kg, double cm) => kg / ((cm / 100) * (cm / 100));
  static double bmr({required double kg, required double cm, required int age, bool male = true}) => (10 * kg) + (6.25 * cm) - (5 * age) + (male ? 5 : -161);
  static double bodyFatEstimate({required double bmi, required int age, bool male = true}) => (1.20 * bmi) + (0.23 * age) - (male ? 16.2 : 5.4);
}
