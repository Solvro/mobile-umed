import "dart:collection";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../common/providers/bottom_sheet_providers.dart";
import "../route_map/providers/route_provider.dart";
import "views/multi_route_view.dart";

class MultiRoutePage extends StatelessWidget {
  const MultiRoutePage({super.key});

  static const String routeName = "/multi_route";

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        sheetStateProvider.overrideWith((ref) => SheetState.visible),
        sheetModeProvider.overrideWith((ref) => SheetMode.expanded),
        expandedRoutesProvider.overrideWith((ref) => LinkedHashSet()),
        sheetTriggerProvider.overrideWith((ref) => true),
      ],
      child: const MultiRouteView(),
    );
  }
}
