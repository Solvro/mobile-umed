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
    final provder = ref.watch(fetchAllRoutesProvider);

    return switch (provder) {
      AsyncData(:final value) => HomeView(routes: value),
      AsyncError() => const FullScreenErrorView(),
      _ => const HomeLoadingView(),
    };
  }
}
