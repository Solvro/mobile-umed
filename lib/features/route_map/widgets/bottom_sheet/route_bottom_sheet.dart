import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/data_source/mocks/mock_songs.dart";
import "../../../../common/providers/bottom_sheet_providers.dart";
import "../../../../common/widgets/main_action_button.dart";
import "../../../../common/widgets/map_bottom_sheet.dart";
import "../../../../common/widgets/secondary_action_button.dart";
import "../modals/end_route_modal.dart";
import "playlist_info_section.dart";
import "route_info_section.dart";

class RouteBottomSheet extends ConsumerStatefulWidget {
  const RouteBottomSheet({super.key, required this.currentSheetMode});

  final SheetMode currentSheetMode;

  @override
  RouteBottomSheetState createState() => RouteBottomSheetState();
}

class RouteBottomSheetState extends ConsumerState<RouteBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MapBottomSheet(
      button: MainActionButton(
        text: context.l10n.end_route,
        backgroundColor: context.colorScheme.secondary,
        onPressed: () async {
          ref.read(sheetTriggerProvider.notifier).state = true;
          await showDialog<EndRouteModal>(context: context, builder: (context) => const EndRouteModal());
        },
      ),
      controls: Row(
        spacing: BottomSheetHeaderConfig.controlsSpacing,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SecondaryActionButton(
            onPressed: () {
              ref.read(sheetModeProvider.notifier).state = SheetMode.half;
            },
            text: context.l10n.route_description,
          ),

          SecondaryActionButton(
            onPressed: () {
              ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
            },
            text: context.l10n.playlist,
          ),
        ],
      ),

      child:
          (widget.currentSheetMode == SheetMode.half)
              ? const RouteInfoSection()
              : PlaylistInfoSection(songs: mockSongs),
    );
  }
}
