import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/mood_provider.dart';

class MoodScreen extends StatelessWidget {
  const MoodScreen({super.key});

  static const moods = [('😞', 1), ('😕', 2), ('😐', 3), ('🙂', 4), ('😄', 5)];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MoodProvider>();
    final selected = provider.todayMood?.emoji;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Mood Tracker', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        GlassCard(
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: moods
                .map(
                  (m) => GestureDetector(
                    onTap: () => context.read<MoodProvider>().saveMood(m.$1, m.$2),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: selected == m.$1 ? Theme.of(context).colorScheme.primary.withOpacity(0.22) : Colors.transparent,
                        boxShadow: selected == m.$1
                            ? [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.35), blurRadius: 18)]
                            : [],
                      ),
                      child: Text(m.$1, style: const TextStyle(fontSize: 26)),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 18),
        GlassCard(
          child: SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                minY: 1,
                maxY: 5,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true))),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    spots: provider.moodHistory
                        .asMap()
                        .entries
                        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.score.toDouble()))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
