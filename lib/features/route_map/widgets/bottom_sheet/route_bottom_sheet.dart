import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../app/theme/color_consts.dart";
import "../../../../common/data_source/mocks/mock_songs.dart";
import "../../../../common/providers/bottom_sheet_providers.dart";
import "../../../../common/widgets/buttons/main_action_button.dart";
import "../../../../common/widgets/buttons/secondary_action_button.dart";
import "../../../../common/widgets/map_bottom_sheet.dart";
import "../../modals/end_route_modal.dart";
import "../../providers/route_provider.dart";
import "sections/playlist_info_section.dart";
import "sections/route_info_section.dart";

class RouteBottomSheet extends ConsumerStatefulWidget {
  const RouteBottomSheet({super.key});

  @override
  RouteBottomSheetState createState() => RouteBottomSheetState();
}

class RouteBottomSheetState extends ConsumerState<RouteBottomSheet> {
  late RouteDetailsOption _chosenOption;

  @override
  void initState() {
    super.initState();
    _chosenOption = RouteDetailsOption.info;
    unawaited(
      Future.microtask(() {
        ref.read(sheetModeProvider.notifier).state = SheetMode.half;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MapBottomSheet(
      button: MainActionButton(
        text: context.l10n.end_route,
        backgroundColor: context.colorScheme.error,
        onPressed: () async {
          ref.read(sheetTriggerProvider.notifier).state = true;
          final bool shouldPop =
              await showDialog<bool>(context: context, builder: (context) => const EndRouteModal()) ?? false;
          if (context.mounted && shouldPop) {
            context.pop();
          }
        },
      ),
      controls: Row(
        spacing: BottomSheetHeaderConfig.controlsSpacing,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SecondaryActionButton(
              onPressed: () {
                ref.read(sheetModeProvider.notifier).state = SheetMode.half;
                setState(() {
                  _chosenOption = RouteDetailsOption.info;
                });
              },
              text: context.l10n.route_description,
              backgroundColor: _chosenOption == RouteDetailsOption.info ? ColorConsts.plumosa : ColorConsts.whiteGray,
              textColor: _chosenOption == RouteDetailsOption.info ? ColorConsts.whiteGray : ColorConsts.plumosa,
            ),
          ),
          Expanded(
            child: SecondaryActionButton(
              onPressed: () {
                ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
                setState(() {
                  _chosenOption = RouteDetailsOption.playlist;
                });
              },
              text: context.l10n.playlist,
              backgroundColor:
                  _chosenOption == RouteDetailsOption.playlist ? ColorConsts.plumosa : ColorConsts.whiteGray,
              textColor: _chosenOption == RouteDetailsOption.playlist ? ColorConsts.whiteGray : ColorConsts.plumosa,
            ),
          ),
        ],
      ),
      child:
          (_chosenOption == RouteDetailsOption.info) ? const RouteInfoSection() : PlaylistInfoSection(songs: mockSongs),
    );
  }
}
