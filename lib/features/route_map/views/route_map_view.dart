import "package:flutter/material.dart" hide Route;
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_tile_caching/flutter_map_tile_caching.dart";

import "../../../app/app.dart";
import "../../../app/config/flutter_map_config.dart";
import "../../../common/models/route.dart";

class RouteMapView extends StatelessWidget {
  RouteMapView({super.key, required this.route});

  final Route route;
  final _tileProvider = FMTCTileProvider(stores: const {"mapStore": BrowseStoreStrategy.readUpdateCreate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(initialCenter: route.landmarks.first.location),
            children: [
              TileLayer(urlTemplate: FlutterMapConfig.urlTemplate, tileProvider: _tileProvider, maxZoom: 19),
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
