import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../utils/nested_navigation.dart';
import '../views/home.dart';
import '../views/splash.dart';

part 'routes.g.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedShellRoute<ShellRoutePage>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(path: '/', routes: []),
  ],
)
class ShellRoutePage extends ShellRouteData {
  const ShellRoutePage();

  static final GlobalKey<NavigatorState> $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      NestedNavigation(
        state: state,
        widget: navigator,
      );
}

class HomeRoute extends GoRouteData {
  static const path = 'home';

  const HomeRoute();

  // any user signup and login redirects would go here
  // and be paried up with a required notifier listener

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeView();
}

class SplashRoute extends GoRouteData {
  const SplashRoute();
  static const path = '/splash';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashView();
  }
}

class BaseRoute extends GoRouteData {
  static const path = '/';

  const BaseRoute();

  // any user signup and login redirects would go here
  // and be paried up with a required notifier listener

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeView();
}

/// A page that fades in an out.
class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
            transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) =>
                FadeTransition(
                  opacity: animation.drive(_curveTween),
                  child: child,
                ));

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}
