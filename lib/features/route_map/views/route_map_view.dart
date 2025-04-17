import "package:flutter/material.dart" hide Route;
import "package:flutter_map/flutter_map.dart";
import "../../../app/app.dart";
import "../../../common/models/route.dart";

class RouteMapView extends StatelessWidget {
  const RouteMapView({super.key, required this.route});

  final Route route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: route.landmarks.first.location),
            children: [
              TileLayer(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", maxZoom: 19),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: route.landmarks.map((landmark) => landmark.location).toList(),
                    color: Colors.blue,
                    strokeWidth: 4,
                  ),
                ],
              ),
              MarkerLayer(
                markers:
                    route.landmarks
                        .map((landmark) => Marker(point: landmark.location, child: const Icon(Icons.location_on)))
                        .toList(),
              ),
            ],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(icon: const Icon(Icons.arrow_back), onPressed: context.router.pop),
            ),
          ),
        ],
      ),
    );
  }
}
