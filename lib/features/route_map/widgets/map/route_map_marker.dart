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

    if (start) {
      path = active ? MarkerPaths.activeStart : MarkerPaths.inactiveStart;
      isTextMarker = false;
    } else if (finish) {
      path = active ? MarkerPaths.activeFinish : MarkerPaths.inactiveFinish;
      isTextMarker = false;
    } else if (type == LandmarkType.pulsometer) {
      path = active ? MarkerPaths.activePulsometer : MarkerPaths.inactivePulsometer;
      isTextMarker = false;
    } else {
      if (active) {
        path = visited ? MarkerPaths.visitedCheckpoint : MarkerPaths.unvisitedCheckpoint;
      } else {
        path = MarkerPaths.inactiveCheckpoint;
      }
      isTextMarker = true;
    }

    return isTextMarker ? _textMarker(path, orderValue) : _simpleMarker(path);
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

SvgPicture _simpleMarker(String path) {
  return SvgPicture.asset(path);
}
