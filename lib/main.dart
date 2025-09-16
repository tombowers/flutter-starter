import 'package:flutter/material.dart';
import 'package:template/routing/router.dart';

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
