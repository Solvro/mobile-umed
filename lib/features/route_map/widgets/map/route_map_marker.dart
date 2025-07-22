import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "../../../../app/assets/assets.gen.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../common/models/checkpoint.dart";

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
    late final SvgPicture icon;
    late final bool isTextMarker;
    final orderValue = order?.toString() ?? "";

    (icon, isTextMarker) = switch ((type, active, visited)) {
      (LandmarkType.start, true, _) => (Assets.icons.startActive.svg(), false),
      (LandmarkType.start, false, _) => (Assets.icons.startInactive.svg(), false),
      (LandmarkType.finish, true, _) => (Assets.icons.finishActive.svg(), false),
      (LandmarkType.finish, false, _) => (Assets.icons.finishInactive.svg(), false),
      (LandmarkType.pulsometer, true, true) => (Assets.icons.pulsometerVisited.svg(), false),
      (LandmarkType.pulsometer, true, false) => (Assets.icons.pulsometerUnvisited.svg(), false),
      (LandmarkType.pulsometer, false, _) => (Assets.icons.pulsometerInactive.svg(), false),
      (LandmarkType.checkpoint, true, true) => (Assets.icons.checkpointVisited.svg(), true),
      (LandmarkType.checkpoint, true, false) => (Assets.icons.checkpointUnvisited.svg(), true),
      _ => (Assets.icons.checkpointInactive.svg(), true),
    };

    return isTextMarker ? _textMarker(icon, orderValue) : icon;
  }
}

Stack _textMarker(SvgPicture icon, String value) {
  return Stack(
    alignment: Alignment.topCenter,
    children: [
      icon,
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
