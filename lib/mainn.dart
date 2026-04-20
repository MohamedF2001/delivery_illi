import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/app_config.dart';
import 'core/config/app_theme.dart';
import 'core/config/app_router.dart';

void main() {
  currentFlavor = AppFlavor.client;
  runApp(const ProviderScope(child: IllicoApp()));
}

class IllicoApp extends ConsumerWidget {
  const IllicoApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'ILLICO DELIVERY',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
