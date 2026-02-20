import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/mood_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/scale_tap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mood = context.watch<MoodProvider>().todayMood;
    final streak = context.watch<TaskProvider>().streak;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Hi, Learner 🌱', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 6),
        Text('You are doing better than you think.'),
        const SizedBox(height: 16),
        GlassCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today\'s mood: ${mood?.emoji ?? 'Not set'}'),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.9, end: 1.1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
                builder: (_, value, child) => Transform.scale(scale: value, child: child),
                onEnd: () {},
                child: Text('🔥 $streak day streak'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _QuickCard(title: 'Talk to AI', icon: Icons.chat_bubble_outline),
            _QuickCard(title: 'Journal', icon: Icons.menu_book_outlined),
            _QuickCard(title: 'Tasks', icon: Icons.check_circle_outline),
            _QuickCard(title: 'Insights', icon: Icons.insights_outlined),
          ],
        ),
      ],
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.sizeOf(context).width - 44) / 2,
      child: ScaleTap(
        onTap: () {},
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
