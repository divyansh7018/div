import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../constants/app_constants.dart';
class CircularProgressWidget extends StatelessWidget { const CircularProgressWidget({required this.percent, required this.label, required this.center, super.key}); final double percent; final String label, center; @override Widget build(BuildContext context) => CircularPercentIndicator(radius: 62, lineWidth: 12, animation: true, percent: percent.clamp(0, 1), circularStrokeCap: CircularStrokeCap.round, backgroundColor: Colors.white10, progressColor: AppConstants.gold, center: Text(center, style: const TextStyle(fontWeight: FontWeight.bold)), footer: Padding(padding: const EdgeInsets.only(top: 8), child: Text(label))); }
