import "package:flutter/material.dart";

import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../app/theme/color_consts.dart";
import "../../../features/route_map/providers/route_provider.dart";

class RouteSegmentedButton extends StatelessWidget {
  const RouteSegmentedButton({super.key, required this.chosenOption, required this.onSelectionChanged});

  final RouteDetailsOption chosenOption;
  final void Function(Set<RouteDetailsOption>) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<RouteDetailsOption>(
      showSelectedIcon: false,
      segments: <ButtonSegment<RouteDetailsOption>>[
        ButtonSegment<RouteDetailsOption>(
          value: RouteDetailsOption.info,
          label: Text(
            context.l10n.route_description,
            style: context.textTheme.titleMedium?.copyWith(
              color: chosenOption == RouteDetailsOption.info ? ColorConsts.whiteGray : ColorConsts.plumosa,
            ),
          ),
        ),
        ButtonSegment<RouteDetailsOption>(
          value: RouteDetailsOption.playlist,
          label: Text(
            context.l10n.playlist,
            style: context.textTheme.titleMedium?.copyWith(
              color: chosenOption == RouteDetailsOption.playlist ? ColorConsts.whiteGray : ColorConsts.plumosa,
            ),
          ),
        ),
      ],
      selected: <RouteDetailsOption>{chosenOption},
      onSelectionChanged: onSelectionChanged,
    );
  }
}
