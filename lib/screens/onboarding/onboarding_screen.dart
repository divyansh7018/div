import 'package:flutter/material.dart';

import '../home/home_shell_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  final pages = const [
    ('You are not alone', 'MindMitra listens with warmth and zero judgment.', Icons.favorite_outline),
    ('Small steps matter', 'Track mood, build streaks, and celebrate progress.', Icons.insights_outlined),
    ('Support anytime', 'Chat, vent, and rescue mode for late-night overthinking.', Icons.nights_stay_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (value) => setState(() => _index = value),
                itemBuilder: (context, i) {
                  final page = pages[i];
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 450),
                    child: Padding(
                      key: ValueKey(i),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(radius: 58, child: Icon(page.$3, size: 52)),
                          const SizedBox(height: 26),
                          Text(page.$1, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
                          const SizedBox(height: 12),
                          Text(page.$2, textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: _index == i ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _index == i ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeShellScreen()),
                  );
                },
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
                child: Text(_index == pages.length - 1 ? 'Start Your Journey' : 'Skip & Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
