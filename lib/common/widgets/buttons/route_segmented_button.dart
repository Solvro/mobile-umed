import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
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
      style: SegmentedButton.styleFrom(
        backgroundColor: ColorConsts.whiteGray,
        foregroundColor: ColorConsts.plumosa,
        selectedForegroundColor: ColorConsts.whiteGray,
        selectedBackgroundColor: ColorConsts.plumosa,
        side: const BorderSide(color: ColorConsts.plumosa, width: ButtonsConfig.segmentedButtonBorderWidth),
      ),
      segments: <ButtonSegment<RouteDetailsOption>>[
        ButtonSegment<RouteDetailsOption>(
          value: RouteDetailsOption.info,
          label: Text(
            context.l10n.route_description,
            style: const TextStyle(
              fontSize: ButtonsConfig.segmentedButtonFontSize,
              fontWeight: ButtonsConfig.segmentedButtonFontWeight,
            ),
          ),
        ),
        ButtonSegment<RouteDetailsOption>(
          value: RouteDetailsOption.playlist,
          label: Text(
            context.l10n.playlist,
            style: const TextStyle(
              fontSize: ButtonsConfig.segmentedButtonFontSize,
              fontWeight: ButtonsConfig.segmentedButtonFontWeight,
            ),
          ),
        ),
      ],
      selected: <RouteDetailsOption>{chosenOption},
      onSelectionChanged: onSelectionChanged,
    );
  }
}
