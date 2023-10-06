// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $shellRoutePage,
    ];

RouteBase get $shellRoutePage => ShellRouteData.$route(
      navigatorKey: ShellRoutePage.$navigatorKey,
      factory: $ShellRoutePageExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          factory: $HomeRouteExtension._fromState,
        ),
      ],
    );

extension $ShellRoutePageExtension on ShellRoutePage {
  static ShellRoutePage _fromState(GoRouterState state) =>
      const ShellRoutePage();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
