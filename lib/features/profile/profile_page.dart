import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../error/views/full_screen_error_view.dart";
import "../route_map/repository/route_map_repository.dart";
import "./views/profile_view.dart";

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const String routeName = "/profile";
  static const Icon icon = Icon(Icons.settings);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(fetchAllRoutesProvider);

    return switch (provider) {
      AsyncData(:final value) => ProfileView(routes: value),
      AsyncError() => const FullScreenErrorView(),
      _ => const Scaffold(body: Text("loading")), // TODO(tomasz-trela): add loading
    };
  }
}
