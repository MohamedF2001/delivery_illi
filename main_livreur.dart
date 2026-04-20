import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'lib/core/config/app_config.dart';
import 'lib/core/config/app_theme.dart';
import 'lib/core/config/app_router.dart';

void main() {
  currentFlavor = AppFlavor.livreur;
  runApp(const ProviderScope(child: _App()));
}

class _App extends ConsumerWidget {
  const _App();
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    title: 'ILLICO Livreur',
    theme: AppTheme.light,
    routerConfig: ref.watch(routerProvider),
    debugShowCheckedModeBanner: false,
  );
}
