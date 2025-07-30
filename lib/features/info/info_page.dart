import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../error/views/full_screen_error_view.dart";
import "repository/info_repository.dart";
import "views/info_loading_view.dart";
import "views/info_view.dart";

class InfoPage extends ConsumerWidget {
  const InfoPage({super.key});

  static const routeName = "/info";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combinedRef = ref.watch(fetchCreatorsAndInfosProvider);

    return switch (combinedRef) {
      AsyncData(:final value) =>
        InfoView(creators: value.creators, infoSections: value.infoSections),
      AsyncError() => const FullScreenErrorView(),
      _ => const InfoLoadingView(),
    };
  }
}
