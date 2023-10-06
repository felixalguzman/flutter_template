import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template/routes/router_listenable.dart';
import 'package:flutter_template/routes/routes.dart';
import 'package:flutter_template/themes/theme_provider.dart';
import 'package:flutter_template/utils/scaffold_provider.dart';
import 'package:flutter_template/views/login.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themesProvider);
    final darkScheme = ref.watch(darkThemeProvider);
    final lightScheme = ref.watch(lightThemeProvider);
    final notifier = ref.watch(routerListenableProvider.notifier);
    final scaffoldMessengerKey = ref.watch(scaffoldMessengerKeyProvider);

    final router = useMemoized(() => GoRouter(
          initialLocation: '/login',
          refreshListenable: notifier,
          routes: [
            ...$appRoutes,
            GoRoute(
              path: '/login',
              builder: (context, state) => const LoginView(),
            ),
          ],
          debugLogDiagnostics: true,
        ));

    return MaterialApp.router(
      title: 'Flutter Demo',
      themeMode: themeMode,
      theme: FlexThemeData.light(scheme: lightScheme, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: darkScheme, useMaterial3: true),
      routerConfig: router,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
