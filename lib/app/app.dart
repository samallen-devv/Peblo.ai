import 'package:flutter/material.dart';

import 'router.dart';

class PebloApp extends StatelessWidget {
  const PebloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Peblo AI Story Buddy',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F3FF),
      ),
    );
  }
}
