import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/routing/routes.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  final GoRouterState state;

  const AppShell({super.key, required this.shell, required this.state});

  @override
  Widget build(BuildContext context) {
    final tabRoots = routes.where((r) => r.isTab).toList();
    final currentTab = tabRoots[shell.currentIndex];

    final path = GoRouter.of(context).routeInformationProvider.value.uri.path;

    final currentRoute = routes.firstWhere(
      (r) => matchPathPattern(r.path, path),
      orElse: () => currentTab,
    );

    final depth = currentTab.depth;

    return ValueListenableBuilder<int>(
      valueListenable: depth!,
      builder: (_, stackDepth, __) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            title: Text(currentRoute.title),
            leading:
                (currentTab.navigatorKey?.currentState?.canPop() ?? false)
                    ? IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed:
                          () =>
                              currentTab.navigatorKey?.currentState?.maybePop(),
                    )
                    : null,
          ),
          body: shell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: shell.currentIndex,
            onDestinationSelected:
                (index) => shell.goBranch(index, initialLocation: true),
            destinations:
                tabRoots
                    .map(
                      (r) => NavigationDestination(
                        icon: Icon(r.icon),
                        label: r.label!,
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }

  bool matchPathPattern(String pattern, String actual) {
    final patternSegments = pattern.split('/');
    final actualSegments = actual.split('/');

    if (patternSegments.length != actualSegments.length) return false;

    for (var i = 0; i < patternSegments.length; i++) {
      final p = patternSegments[i];
      final a = actualSegments[i];

      if (p.startsWith(':')) continue; // it's a param, so accept any value
      if (p != a) return false;
    }

    return true;
  }
}
