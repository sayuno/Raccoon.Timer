import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/providers.dart';
import 'features/fire/fire_screen.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Shared container so the notification-tap handler (outside the widget tree)
  // can read the database and open the FireScreen.
  final container = ProviderContainer();

  await NotificationService.instance.init(
    onTapPayload: (payload) => _openFire(container, payload),
  );

  // If a notification cold-started the app, route to its FireScreen.
  final launchPayload = await NotificationService.instance.launchPayload();

  runApp(UncontrolledProviderScope(
    container: container,
    child: const RaccoonTimerApp(),
  ));

  if (launchPayload != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _openFire(container, launchPayload));
  }
}

Future<void> _openFire(ProviderContainer container, String? payload) async {
  final id = int.tryParse(payload ?? '');
  if (id == null) return;
  final db = container.read(databaseProvider);
  final routine = await db.routineById(id);
  if (routine == null) return;
  final type = await db.typeById(routine.typeId);
  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (_) => FireScreen(routine: routine, type: type)),
  );
}
