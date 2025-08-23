import "package:flutter/material.dart";

import "views/multi_route_view.dart";

class MultiRoutePage extends StatelessWidget {
  const MultiRoutePage({super.key});

  static const String routeName = "/multi_route";

  @override
  Widget build(BuildContext context) {
    return const MultiRouteView();
  }
}
