import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../common/models/bottom_sheet_mode.dart";
import "../../../common/models/route.dart";
import "../../../common/models/song.dart";
import "../../../common/widgets/map_bottom_sheet.dart";
import "../../../common/widgets/sheet_top_handle.dart";
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
            button: ElevatedButton(onPressed: () {}, child: const Text("Zakoncz trase")),
            controls: SheetTopHandle(
              controls: Row(
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
            ),
            child:
                (_currentSheetMode == SheetMode.half)
                    ? const RouteInfoSection()
                    : PlaylistInfoSection(
                      songs:
                          [
                            const Song(author: "Shakira", name: "Waka waka", duration: 200),
                            const Song(author: "Shakira", name: "Waka waka", duration: 200),
                            const Song(author: "Shakira", name: "Waka waka", duration: 200),
                            const Song(author: "Kmal", name: "Waka waka", duration: 200),
                            const Song(author: "Shakira", name: "Waka waka", duration: 200),
                            const Song(author: "Shakira", name: "Waka waka", duration: 200),
                            const Song(author: "Enej", name: "Waka waka", duration: 200),
                          ].lock,
                    ),
          ),
        ],
      ),
    );
  }
}
