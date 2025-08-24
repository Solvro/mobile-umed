import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../common/providers/completed_routes_provider.dart";
import "../error/views/full_screen_error_view.dart";
import "../map/route_map/repository/route_map_repository.dart";
import "./views/profile_view.dart";

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const String routeName = "/profile";
  static const Icon icon = Icon(Icons.settings);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routesProvider = ref.watch(fetchAllRoutesProvider);
    final compledtedRoutesProvider = ref.watch(completedRoutesProvider);

    final providers = (routesProvider, compledtedRoutesProvider);

    return switch (providers) {
      (AsyncData(value: final routes), AsyncData(value: final completedRoutes)) => ProfileView(
        routes: routes,
        completedRoutes: completedRoutes,
      ),
      (AsyncError(:final error, :final stackTrace), _) => FullScreenErrorView(
        message: kDebugMode ? "$error\n$stackTrace" : null,
      ),
      _ => const Scaffold(body: Text("loading")), // TODO(tomasz-trela): add loading
    };
  }
}

//
