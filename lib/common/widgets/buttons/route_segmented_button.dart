import "package:flutter/material.dart";

import "../../../app/l10n/l10n.dart";
import "../../../features/map/route_map/providers/route_provider.dart";

class RouteSegmentedButton extends StatelessWidget {
  const RouteSegmentedButton({super.key, required this.chosenOption, required this.onSelectionChanged});

  final RouteDetailsOption chosenOption;
  final void Function(Set<RouteDetailsOption>) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<RouteDetailsOption>(
      showSelectedIcon: false,
      segments: <ButtonSegment<RouteDetailsOption>>[
        ButtonSegment<RouteDetailsOption>(value: RouteDetailsOption.info, label: Text(context.l10n.route_description)),
        ButtonSegment<RouteDetailsOption>(value: RouteDetailsOption.playlist, label: Text(context.l10n.playlist)),
      ],
      selected: <RouteDetailsOption>{chosenOption},
      onSelectionChanged: onSelectionChanged,
    );
  }
}
