import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/routing/router.dart';
import 'package:template/routing/routes.dart';

void main() {
  runApp(const AppEntrypoint());
}

class AppEntrypoint extends StatelessWidget {
  const AppEntrypoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

class AppShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  final GoRouterState state;

  const AppShell({super.key, required this.shell, required this.state});

  @override
  Widget build(BuildContext context) {
    final tabRoots = routes.where((r) => r.isTab).toList();
    final currentTab = tabRoots[shell.currentIndex];
    final currentRoute = routes.firstWhere(
      (r) => state.uri.path == r.path,
      orElse: () => currentTab,
    );

    final depth = currentTab.depth;

    return ValueListenableBuilder<int>(
      valueListenable: depth!,
      builder: (_, stackDepth, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(currentRoute.title),
            leading:
                (currentTab.navigatorKey?.currentState?.canPop() ?? false)
                    ? IconButton(
                      icon: const Icon(Icons.arrow_back),
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
}
