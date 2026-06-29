import 'package:flutter/material.dart';
import 'diet_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import 'workout_screen.dart';
class MainShellScreen extends StatefulWidget { const MainShellScreen({super.key}); @override State<MainShellScreen> createState() => _MainShellScreenState(); }
class _MainShellScreenState extends State<MainShellScreen> { int index = 0; final screens = const [HomeScreen(), WorkoutScreen(), DietScreen(), ProgressScreen(), ProfileScreen()]; @override Widget build(BuildContext context) => Scaffold(body: AnimatedSwitcher(duration: const Duration(milliseconds: 280), child: screens[index]), bottomNavigationBar: BottomNavigationBar(currentIndex: index, onTap: (v) => setState(() => index = v), items: const [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workout'), BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Diet'), BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progress'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')])); }
}
