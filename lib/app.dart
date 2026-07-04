import 'package:flutter/material.dart';

import 'features/home/home_screen.dart';
import 'theme/app_theme.dart';

/// Global navigator so a fired notification can route to the FireScreen from
/// outside the widget tree.
final navigatorKey = GlobalKey<NavigatorState>();

class RaccoonTimerApp extends StatelessWidget {
  const RaccoonTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raccoon Timer',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: buildDarkTheme(),
      home: const HomeScreen(),
    );
  }
}
