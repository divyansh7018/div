import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../providers/mood_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/scale_tap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.onQuickNavigate, super.key});

  final ValueChanged<int> onQuickNavigate;

  @override
  Widget build(BuildContext context) {
    final mood = context.watch<MoodProvider>().todayMood;
    final streak = context.watch<TaskProvider>().streak;
    final userName = context.watch<AuthProvider>().user?.name ?? 'Learner';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Hi, $userName 🌱', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 6),
        const Text('You are doing better than you think.'),
        const SizedBox(height: 16),
        GlassCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: Text('Today\'s mood: ${mood?.emoji ?? 'Not set'}')),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.9, end: 1.1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (_, value, child) => Transform.scale(scale: value, child: child),
                child: Text('🔥 $streak day streak'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _QuickCard(title: 'Talk to AI', icon: Icons.chat_bubble_outline, onTap: () => onQuickNavigate(2)),
            _QuickCard(title: 'Journal', icon: Icons.menu_book_outlined, onTap: () => onQuickNavigate(3)),
            _QuickCard(title: 'Tasks', icon: Icons.check_circle_outline, onTap: () => onQuickNavigate(4)),
            _QuickCard(title: 'Insights', icon: Icons.insights_outlined, onTap: () => onQuickNavigate(5)),
          ],
        ),
      ],
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({required this.title, required this.icon, required this.onTap});

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 44) / 2,
      child: ScaleTap(
        onTap: onTap,
        child: Hero(
          tag: title,
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon),
                const SizedBox(height: 10),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
