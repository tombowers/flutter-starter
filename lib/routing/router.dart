import 'package:go_router/go_router.dart';
import 'package:template/routing/app_shell.dart';
import 'package:template/routing/routes.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => AppShell(shell: shell, state: state),
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
