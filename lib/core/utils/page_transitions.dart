import 'package:flutter/material.dart';

class FadeSlidePageRoute<T> extends PageRouteBuilder<T> {
  FadeSlidePageRoute({required Widget page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: const Duration(milliseconds: 380),
          reverseTransitionDuration: const Duration(milliseconds: 280),
          transitionsBuilder: (_, animation, __, child) {
            final offsetTween = Tween(begin: const Offset(0.08, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOutCubic));
            return FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
              child: SlideTransition(position: animation.drive(offsetTween), child: child),
            );
          },
        );
}
