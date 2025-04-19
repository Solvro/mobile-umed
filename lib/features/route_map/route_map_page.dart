import "package:flutter/material.dart";

import "../../common/data_source/mocks/mock_routes.dart";
import "views/route_map_view.dart";

class RouteMapPage extends StatelessWidget {
  const RouteMapPage({super.key, required this.id});

  final int id;
  static const routeName = "/route_map";

  @override
  Widget build(BuildContext context) => RouteMapView(route: mockData[id]);
}
