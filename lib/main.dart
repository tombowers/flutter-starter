import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/routing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

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

class MyShell extends StatelessWidget {
  final StatefulNavigationShell shell;
  final GoRouterState state;

  const MyShell({super.key, required this.shell, required this.state});

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
