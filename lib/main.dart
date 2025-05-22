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
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
