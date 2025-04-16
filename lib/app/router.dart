part of "app.dart";

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
final _shellNavigatorAchievementsKey = GlobalKey<NavigatorState>();
final _shellNavigatorOthersKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  initialLocation: HomePage.routeName,
  navigatorKey: _rootNavigatorKey,
  // routes: <RouteBase>[GoRoute(path: HomePage.routeName, builder: (_, state) => const HomePage())],
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavbar(navigationShell: navigationShell);
      },
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
}
