import "package:flutter/material.dart";
import "../../../../common/models/landmark.dart";

class RouteMapMarker extends StatelessWidget {
  const RouteMapMarker({super.key, required this.type, required this.active, this.start = false, this.finish = false});
  final LandmarkType type;
  final bool active;
  final bool start;
  final bool finish;

  @override
  Widget build(BuildContext context) {
    if (start) {
      return active
          ? const Icon(Icons.play_arrow, color: Colors.green)
          : const Icon(Icons.play_arrow, color: Colors.grey);
    }
    if (finish) {
      return active ? const Icon(Icons.flag, color: Colors.green) : const Icon(Icons.flag, color: Colors.grey);
    }
    if (type == LandmarkType.pulsometer) {
      return active
          ? const Icon(Icons.monitor_heart, color: Colors.green)
          : const Icon(Icons.monitor_heart, color: Colors.grey);
    }
    return active
        ? const Icon(Icons.location_pin, color: Colors.green)
        : const Icon(Icons.location_pin, color: Colors.grey);
  }
}
