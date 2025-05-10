import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../common/data_source/mocks/mock_songs.dart";
import "../../../app/app.dart";
import "../../../common/models/bottom_sheet_mode.dart";
import "../../../common/models/route.dart";
import "../../../common/widgets/map_bottom_sheet.dart";
import "../widgets/bottom_sheet/playlist_info_section.dart";
import "../widgets/bottom_sheet/route_info_section.dart";
import "../widgets/map/route_map_widget.dart";
import "../widgets/progress_bar/route_progress_bar.dart";

class RouteMapView extends ConsumerStatefulWidget {
  const RouteMapView({super.key, required this.route});

  final Route route;

  @override
  _RouteMapViewState createState() => _RouteMapViewState();
}

class _RouteMapViewState extends ConsumerState<RouteMapView> {
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
            button: ElevatedButton(
              onPressed: () {
                context.router.pop();
              },
              child: const Text("Zakoncz trase"),
            ),
            controls: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(sheetModeProvider.notifier).state = SheetMode.half;
                  },
                  child: const Text("1"),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
                  },
                  child: const Text("2"),
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
