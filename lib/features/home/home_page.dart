import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../error/views/full_screen_error_view.dart";
import "../route_map/repository/route_map_repository.dart";
import "./views/home_view.dart";
import "views/home_loading_view.dart";

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const String routeName = "/home";
  static const Icon icon = Icon(Icons.home);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("home");
    final provider = ref.watch(fetchAllRoutesProvider);

    return switch (provider) {
      AsyncData(:final value) => HomeView(routes: value),
      AsyncError(:final error, :final stackTrace) => FullScreenErrorView(
        message: kDebugMode ? "$error\n$stackTrace" : null,
      ),
      _ => const HomeLoadingView(),
    };
  }
}
