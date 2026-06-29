import 'package:flutter/material.dart';

extension NumFormatX on num {
  String compact([String suffix = '']) => '${toStringAsFixed(truncateToDouble() == this ? 0 : 1)}$suffix';
}

extension ContextX on BuildContext {
  bool get wide => MediaQuery.sizeOf(this).width >= 700;
  EdgeInsets get pagePadding => EdgeInsets.symmetric(horizontal: wide ? 32 : 16, vertical: 12);
}
