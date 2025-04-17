part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorAchievementsKey = GlobalKey<NavigatorState>();
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
      builder:
          (_, _, navigationShell) => DashboardPage(
            navigationShell: navigationShell,
            items: const <NavItem>[
              (label: HomePage.label, icon: HomePage.icon),
              (label: AchievementsPage.label, icon: AchievementsPage.icon),
              (label: OthersPage.label, icon: OthersPage.icon),
            ],
          ),
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: HomePage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAchievementsKey,
          routes: [
            GoRoute(
              path: AchievementsPage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(child: AchievementsPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorOthersKey,
          routes: [
            GoRoute(
              path: OthersPage.routeName,
              pageBuilder: (context, state) => const NoTransitionPage(child: OthersPage()),
            ),
          ],
        ),
      ],
    ),
  ],
);

extension ContexRouterX on BuildContext {
  GoRouter get router => GoRouter.of(this);
}

extension RouterX on GoRouter {
  void goHome() => go(HomePage.routeName);
  Future<void> pushRouteMap(int id) async => push("${RouteMapPage.routeName}/$id");
}
