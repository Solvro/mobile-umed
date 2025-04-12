part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: HomePage.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[GoRoute(path: HomePage.routeName, builder: (_, state) => const HomePage())],
);

extension ContexRouterX on BuildContext {
  GoRouter get router => GoRouter.of(this);
}

extension RouterX on GoRouter {
  void goHome() => go(HomePage.routeName);
}
