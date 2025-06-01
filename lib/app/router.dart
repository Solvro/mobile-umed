part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorProfileKey = GlobalKey<NavigatorState>();
final _shellNavigatorOthersKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: HomePage.routeName,
  navigatorKey: _rootNavigatorKey,
  routes: [
    // this route is temporary here
    GoRoute(
      path: "${RouteMapPage.routeName}/:id",
      pageBuilder: (context, state) {
        final id = int.parse(state.pathParameters["id"]!);
        return NoTransitionPage(child: RouteMapPage(id: id));
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
          navigatorKey: _shellNavigatorOthersKey,
          routes: [GoRoute(path: OthersPage.routeName, builder: (context, state) => const _NotImplementedPage())],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProfileKey,
          routes: [GoRoute(path: ProfilePage.routeName, builder: (context, state) => const ProfilePage())],
        ),
      ],
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
  Future<void> pushRouteMap(int id) async => push("${RouteMapPage.routeName}/$id");
  Future<void> pushPlayground() async => push(DebugPlayground.routeName);
}

//temp
class _NotImplementedPage extends StatelessWidget {
  const _NotImplementedPage();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Not implemented yet"));
  }
}
