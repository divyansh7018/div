import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/task_provider.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin {
  late final ConfettiController _confettiController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Daily Micro Tasks', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text('Streak: ${provider.streak} days 🔥'),
            const SizedBox(height: 14),
            ...provider.tasks.map(
              (task) => CheckboxListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                value: task.isCompleted,
                title: Text(task.title),
                onChanged: (value) async {
                  await context.read<TaskProvider>().toggleTask(task, value);
                  if (context.read<TaskProvider>().allDone) {
                    _confettiController.play();
                  }
                },
              ),
            ),
          ],
        ),
        ConfettiWidget(confettiController: _confettiController, blastDirectionality: BlastDirectionality.explosive),
        Positioned(
          right: 18,
          bottom: 20,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.05).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut)),
            child: FloatingActionButton.extended(onPressed: () {}, icon: const Icon(Icons.self_improvement), label: const Text('Breathe')),
          ),
        ),
      ],
    );
  }
}
