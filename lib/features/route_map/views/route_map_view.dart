import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../common/providers/bottom_sheet_providers.dart";
import "../providers/route_provider.dart";
import "../widgets/bottom_sheet/progress_bar/route_progress_bar.dart";
import "../widgets/bottom_sheet/route_bottom_sheet.dart";
import "../widgets/bottom_sheet/select_route_bottom_sheet.dart";
import "../widgets/map/route_map_widget.dart";

class RouteMapView extends ConsumerStatefulWidget {
  const RouteMapView({super.key});

  @override
  RouteMapViewState createState() => RouteMapViewState();
}

class RouteMapViewState extends ConsumerState<RouteMapView> {
  late SheetState _currentSheetState;

  @override
  void initState() {
    super.initState();
    _currentSheetState = ref.read(sheetStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(routeProvider);

    ref.listen<SheetState>(sheetStateProvider, (previous, next) {
      if (next != _currentSheetState) {
        setState(() {
          _currentSheetState = next;
        });
      }
    });

    final landmarks = route?.landmarks ?? IList();
    final visitedCount = landmarks.isEmpty ? 0 : (landmarks.length <= 2 ? landmarks.length : 2);

    return Scaffold(
      body: Stack(
        children: [
          if (route != null) ...[
            RouteMapWidget(
              landmarks: route.landmarks,
              visitedCount: visitedCount,
              active: _currentSheetState == SheetState.hidden,
            ),
            RouteProgressBar(landmarks: route.landmarks, visitedCount: 3),
            const RouteBottomSheet(),
          ] else ...[
            RouteMapWidget(active: _currentSheetState == SheetState.hidden),
            ChooseRouteBottomSheet(),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    ref.read(routeProvider.notifier).state = null;
    super.dispose();
  }
}
