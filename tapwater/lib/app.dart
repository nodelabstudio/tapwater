import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes/router.dart';
import 'config/theme/app_theme.dart';
import 'core/providers/widget_provider.dart';
import 'core/services/preferences_service.dart';

/// Global key for the root ScaffoldMessenger so snackbars survive widget rebuilds.
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class TapWaterApp extends ConsumerWidget {
  const TapWaterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    ref.watch(widgetUpdateProvider);
    return MaterialApp.router(
      title: 'TapWater',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
