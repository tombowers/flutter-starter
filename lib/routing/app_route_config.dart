import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/routing/stack_observer.dart';

class AppRouteConfig {
  final String path;
  final String title;
  final Widget Function(BuildContext, GoRouterState) builder;
  final bool includeInNav;
  final IconData? icon;
  final String? label;

  final GlobalKey<NavigatorState>? navigatorKey;
  final StackObserver? observer;

  AppRouteConfig({
    required this.path,
    required this.title,
    required this.builder,
    this.includeInNav = false,
    this.icon,
    this.label,
  }) : navigatorKey =
           includeInNav ? GlobalKey<NavigatorState>(debugLabel: path) : null,
       observer = includeInNav ? StackObserver() : null;

  bool get isTab => includeInNav;
  ValueNotifier<int>? get depth => observer?.depth;
}
