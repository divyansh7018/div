import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/time_utils.dart';
import '../../providers/theme_provider.dart';
import '../chat/chat_screen.dart';
import '../insights/insights_screen.dart';
import '../journal/journal_screen.dart';
import '../mood/mood_screen.dart';
import '../tasks/tasks_screen.dart';
import 'home_screen.dart';

class HomeShellScreen extends StatefulWidget {
  const HomeShellScreen({super.key});

  @override
  State<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends State<HomeShellScreen> {
  int _currentIndex = 0;

  final _pages = const [HomeScreen(), MoodScreen(), ChatScreen(), JournalScreen(), TasksScreen(), InsightsScreen()];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLateNightRescueWindow(DateTime.now())) {
        _showRescuePopup();
      }
    });
  }

  void _showRescuePopup() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Late Night Rescue Mode'),
        content: const Text('Try box breathing: Inhale 4s • Hold 4s • Exhale 6s. Repeat for 2 minutes.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('I will try'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MindMitra'),
        actions: [
          IconButton(
            onPressed: context.read<ThemeProvider>().toggleTheme,
            icon: const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: AnimatedSwitcher(duration: const Duration(milliseconds: 260), child: _pages[_currentIndex]),
      bottomNavigationBar: GlassCard(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(icon: Icons.home_rounded, index: 0, currentIndex: _currentIndex, onTap: _setIndex),
            _NavItem(icon: Icons.mood_rounded, index: 1, currentIndex: _currentIndex, onTap: _setIndex),
            _NavItem(icon: Icons.chat_rounded, index: 2, currentIndex: _currentIndex, onTap: _setIndex),
            _NavItem(icon: Icons.menu_book_rounded, index: 3, currentIndex: _currentIndex, onTap: _setIndex),
            _NavItem(icon: Icons.task_alt_rounded, index: 4, currentIndex: _currentIndex, onTap: _setIndex),
            _NavItem(icon: Icons.bar_chart_rounded, index: 5, currentIndex: _currentIndex, onTap: _setIndex),
          ],
        ),
      ),
    );
  }

  void _setIndex(int value) => setState(() => _currentIndex = value);
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.index, required this.currentIndex, required this.onTap});

  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final selected = index == currentIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).colorScheme.primary.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(icon, color: selected ? Theme.of(context).colorScheme.primary : null),
      ),
    );
  }
}
