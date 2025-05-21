import 'package:flutter/material.dart';

class StackObserver extends NavigatorObserver {
  final depth = ValueNotifier<int>(1);

  void _updateDepth(int newValue) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      depth.value = newValue;
    });
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _updateDepth(depth.value + 1);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _updateDepth((depth.value - 1).clamp(1, 100));
  }
}
