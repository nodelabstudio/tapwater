import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes/router.dart';
import 'config/theme/app_theme.dart';

/// Global key for the root ScaffoldMessenger so snackbars survive widget rebuilds.
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class TapWaterApp extends ConsumerWidget {
  const TapWaterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'TapWater',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
