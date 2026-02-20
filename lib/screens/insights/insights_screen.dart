import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/mood_provider.dart';
import '../../providers/task_provider.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moodProvider = context.watch<MoodProvider>();
    final taskProvider = context.watch<TaskProvider>();

    final avgMood = moodProvider.moodHistory.isEmpty
        ? 0.0
        : moodProvider.moodHistory.map((m) => m.score).reduce((a, b) => a + b) / moodProvider.moodHistory.length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Insights Dashboard', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        GlassCard(child: Text('Mood trend score: ${avgMood.toStringAsFixed(1)} / 5')),
        const SizedBox(height: 12),
        GlassCard(child: Text('Task completion: ${taskProvider.tasks.where((t) => t.isCompleted).length}/${taskProvider.tasks.length}')),
        const SizedBox(height: 12),
        const GlassCard(
          child: Text('AI Summary: You are building consistency. Keep focusing on one tiny act of self-kindness each day.'),
        ),
      ],
    );
  }
}
