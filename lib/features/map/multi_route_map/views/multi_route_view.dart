import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../route_map/repository/route_map_repository.dart";
import "../widgets/multi_route_map_widget.dart";
import "../widgets/select_route_bottom_sheet.dart";

class MultiRouteView extends ConsumerStatefulWidget {
  const MultiRouteView({super.key});

  @override
  ConsumerState<MultiRouteView> createState() => _MultiRouteViewState();
}

class _MultiRouteViewState extends ConsumerState<MultiRouteView> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final allRoutes = ref.watch(fetchAllRoutesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.choose_route),
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
      ),
      body: switch (allRoutes) {
        AsyncData(:final value) => Stack(
          children: [const MultiRouteMapWidget(), SelectRouteBottomSheet(routes: value)],
        ),
        AsyncLoading() => const CircularProgressIndicator(),
        _ => Center(child: Text(context.l10n.errors_generic)),
      },
    );
  }
}
