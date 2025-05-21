import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../common/models/route.dart";
import "../../../common/providers/bottom_sheet_providers.dart";
import "../widgets/bottom_sheet/route_bottom_sheet.dart";
import "../widgets/bottom_sheet/select_route_bottom_sheet.dart";
import "../widgets/map/route_map_widget.dart";
import "../widgets/progress_bar/route_progress_bar.dart";

class RouteMapView extends ConsumerStatefulWidget {
  const RouteMapView({super.key, required this.route});

  final Route? route;

  @override
  RouteMapViewState createState() => RouteMapViewState();
}

class RouteMapViewState extends ConsumerState<RouteMapView> {
  late SheetMode _currentSheetMode;
  late SheetState _currentSheetState;
  late Route? _currentRoute;

  @override
  void initState() {
    super.initState();
    _currentSheetMode = ref.read(sheetModeProvider);
    _currentSheetState = ref.read(sheetStateProvider);
    _currentRoute = widget.route;
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

    ref.listen<SheetState>(sheetStateProvider, (previous, next) {
      if (next != _currentSheetState) {
        setState(() {
          _currentSheetState = next;
        });
      }
    });

    final landmarks = _currentRoute?.landmarks ?? IList();
    final visitedCount = landmarks.isEmpty ? 0 : (landmarks.length <= 2 ? landmarks.length : 2);

    return Scaffold(
      body: Stack(
        children: [
          if (_currentRoute != null) ...[
            RouteMapWidget(
              landmarks: _currentRoute?.landmarks ?? IList(),
              visitedCount: visitedCount,
              active: _currentSheetState == SheetState.hidden,
            ),
            RouteProgressBar(landmarks: _currentRoute!.landmarks, visitedCount: 3),
            RouteBottomSheet(currentSheetMode: _currentSheetMode),
          ] else ...[
            RouteMapWidget(active: _currentSheetState == SheetState.hidden),
            ChooseRouteBottomSheet(),
          ],
        ],
      ),
    );
  }
}
