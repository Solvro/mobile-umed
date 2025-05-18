import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../common/models/landmark.dart";

class RouteMapMarker extends StatelessWidget {
  const RouteMapMarker({
    super.key,
    required this.type,
    required this.active,
    this.start = false,
    this.finish = false,
    this.visited = false,
    this.order,
  });

  final LandmarkType type;
  final bool active;
  final bool start;
  final bool finish;
  final bool visited;
  final int? order;

  @override
  Widget build(BuildContext context) {
    late final String path;
    late final bool isTextMarker;
    final orderValue = order?.toString() ?? "";

    (path, isTextMarker) = switch ((start, finish, type, active, visited)) {
      (true, _, _, true, _) => (MarkerPaths.activeStart, false),
      (true, _, _, false, _) => (MarkerPaths.inactiveStart, false),
      (_, true, _, true, _) => (MarkerPaths.activeFinish, false),
      (_, true, _, false, _) => (MarkerPaths.inactiveFinish, false),
      (_, _, LandmarkType.pulsometer, true, _) => (MarkerPaths.activePulsometer, false),
      (_, _, LandmarkType.pulsometer, false, _) => (MarkerPaths.inactivePulsometer, false),
      (_, _, LandmarkType.checkpoint, true, true) => (MarkerPaths.visitedCheckpoint, true),
      (_, _, LandmarkType.checkpoint, true, false) => (MarkerPaths.unvisitedCheckpoint, true),
      _ => (MarkerPaths.inactiveCheckpoint, true),
    };

    return isTextMarker ? _textMarker(path, orderValue) : SvgPicture.asset(path);
  }
}

Stack _textMarker(String path, String value) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      SvgPicture.asset(path),
      Padding(
        padding: const EdgeInsets.all(MapConfig.markerPadding),
        child: Text(
          value,
          style: const TextStyle(fontSize: MapConfig.textSize, color: MapConfig.markerTextColor),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
