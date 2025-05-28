import "package:flutter/material.dart" hide Route;
import "../../../../app/config/ui_config.dart";
import "../../../models/route.dart";
import "route_card.dart";

class RouteListWidget extends StatelessWidget {
  final List<Route> routes;
  final void Function(Route) onRouteTap;
  final double height;
  final double itemWidth;

  const RouteListWidget({
    required this.routes,
    required this.onRouteTap,
    this.height = RouteListConfig.height,
    this.itemWidth = RouteListConfig.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: routes.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppPaddings.tinySmall),
        itemBuilder: (_, index) {
          final route = routes[index];
          return RouteCard(
            key: ValueKey(route.id),
            route: route,
            onTap: () => onRouteTap(route),
            width: itemWidth,
            height: height,
          );
        },
      ),
    );
  }
}
