import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/main.dart';
import 'package:template/pages/details_screen.dart';
import 'package:template/pages/home_screen.dart';
import 'package:template/pages/settings_screen.dart';

final routes = <AppRouteConfig>[
  AppRouteConfig(
    path: '/home',
    title: 'Home',
    builder: (_, __) => const HomeScreen(),
    includeInNav: true,
    icon: Icons.home,
    label: 'Home',
  ),
  AppRouteConfig(
    path: '/home/details',
    title: 'Details',
    builder: (_, __) => const DetailsScreen(),
  ),
  AppRouteConfig(
    path: '/settings',
    title: 'Settings',
    builder: (_, __) => const SettingsScreen(),
    includeInNav: true,
    icon: Icons.settings,
    label: 'Settings',
  ),
];

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MyShell(shell: shell, state: state),
      branches: _buildBranches(),
    ),
  ],
);

List<StatefulShellBranch> _buildBranches() {
  final tabRoots = routes.where((r) => r.isTab).toList();

  return tabRoots.map((root) {
    final children = routes.where(
      (r) => r.path != root.path && r.path.startsWith('${root.path}/'),
    );

    return StatefulShellBranch(
      navigatorKey: root.navigatorKey,
      observers: [root.observer!],
      routes: [
        GoRoute(
          path: root.path,
          builder: root.builder,
          routes:
              children
                  .map(
                    (r) => GoRoute(
                      path: r.path.replaceFirst('${root.path}/', ''),
                      builder: r.builder,
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }).toList();
}

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
