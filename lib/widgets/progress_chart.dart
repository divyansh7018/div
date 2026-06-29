import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/progress_entry.dart';
class ProgressChart extends StatelessWidget { const ProgressChart({required this.entries, super.key}); final List<ProgressEntry> entries; @override Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: SizedBox(height: 190, child: LineChart(LineChartData(gridData: const FlGridData(show: false), borderData: FlBorderData(show: false), titlesData: const FlTitlesData(leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false))), lineBarsData: [LineChartBarData(isCurved: true, color: AppConstants.gold, barWidth: 4, dotData: const FlDotData(show: true), spots: [for (var i = 0; i < entries.length; i++) FlSpot(i.toDouble(), entries[i].weight)])])))); }
}
