import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../common/data_source/mocks/mock_songs.dart";
import "../../../app/app.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/models/bottom_sheet_mode.dart";
import "../../../common/models/route.dart";
import "../../../common/widgets/main_action_button.dart";
import "../../../common/widgets/map_bottom_sheet.dart";
import "../../../common/widgets/secondary_action_button.dart";
import "../widgets/bottom_sheet/playlist_info_section.dart";
import "../widgets/bottom_sheet/route_info_section.dart";
import "../widgets/map/route_map_widget.dart";
import "../widgets/progress_bar/route_progress_bar.dart";

class RouteMapView extends ConsumerStatefulWidget {
  const RouteMapView({super.key, required this.route});

  final Route route;

  @override
  RouteMapViewState createState() => RouteMapViewState();
}

class RouteMapViewState extends ConsumerState<RouteMapView> {
  late SheetMode _currentSheetMode;

  @override
  void initState() {
    super.initState();
    _currentSheetMode = ref.read(sheetModeProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SheetMode>(sheetModeProvider, (previous, next) {
      if (next != _currentSheetMode) {
        setState(() {
          _currentSheetMode = next;
        });
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          RouteMapWidget(landmarks: widget.route.landmarks),
          RouteProgressBar(landmarks: widget.route.landmarks, visitedCount: 3, progressBetweenLandmarks: 0.7),
          MapBottomSheet(
            button: MainActionButton(
              text: "Zakończ trase",
              backgroundColor: context.colorScheme.secondary,
              onPressed: () {
                context.router.pop();
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
                  text: "Opis trasy",
                ),

                SecondaryActionButton(
                  onPressed: () {
                    ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
                  },
                  text: "Playlista",
                ),
              ],
            ),

            child:
                (_currentSheetMode == SheetMode.half)
                    ? const RouteInfoSection()
                    : PlaylistInfoSection(songs: mockSongs),
          ),
        ],
      ),
    );
  }
}
