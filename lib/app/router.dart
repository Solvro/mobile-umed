part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();
final _shellNavigatorInfoKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: HomePage.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: [
    // this route is temporary here
    GoRoute(
      path: RouteMapPage.routeName,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: RouteMapPage());
      },
    ),
    // this route is temporary here
    GoRoute(
      path: "${RouteMapPage.routeName}/:id",
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters["id"]!);
        return NoTransitionPage(key: ValueKey("route_map_$id"), child: RouteMapPage(id: id));
      },
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (_, _, navigationShell) => DashboardPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [GoRoute(path: HomePage.routeName, builder: (context, state) => const HomePage())],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorInfoKey,
          routes: [GoRoute(path: InfoPage.routeName, builder: (context, state) => const InfoPage())],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [GoRoute(path: ProfilePage.routeName, builder: (context, state) => const ProfilePage())],
        ),
      ],
    ),
    GoRoute(
      path: ErrorPage.routeName,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final message = state.uri.queryParameters["message"];
        return ErrorPage(message: message, onBackToHome: () => context.router.goHome());
      },
    ),
    if (kDebugMode)
      GoRoute(
        path: DebugPlayground.routeName,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DebugPlayground(),
      ),
  ],
);

extension ContexRouterX on BuildContext {
  GoRouter get router => GoRouter.of(this);
}

extension RouterX on GoRouter {
  void goHome() => go(HomePage.routeName);
  void goProfile() => go(ProfilePage.routeName);
  Future<void> pushRouteMap({int? id}) async {
    final locationHasPermissions = await LocationService.requestPermissions();

    // TODO(24bartixx): no location permissions popup (or request)
    if (!locationHasPermissions) return;

    await MyFlutterForegroundTask.requestPermissions();

    MyFlutterForegroundTask.initMyService();
    await MyFlutterForegroundTask.startMyForegroundService();

    if (id != null) {
      await push("${RouteMapPage.routeName}/$id");
    } else {
      await push("${RouteMapPage.routeName}/");
    }
  }

  Future<void> pushPlayground() async => push(DebugPlayground.routeName);
  Future<void> pushFullScreenError(String message) async {
    await push("${ErrorPage.routeName}?message=${Uri.encodeComponent(message)}");
  }
}
