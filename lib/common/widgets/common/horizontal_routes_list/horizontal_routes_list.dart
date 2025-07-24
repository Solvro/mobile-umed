import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "../../../../app/config/ui_config.dart";
import "../../../models/route.dart";
import "route_card.dart";

class RouteListWidget extends StatelessWidget {
  final IList<Route> routes;
  final void Function(Route) onRouteTap;
  final double height;
  final double itemWidth;
  final double sideMargin;
  final IconData icon;

  const RouteListWidget({
    required this.routes,
    required this.onRouteTap,
    required this.icon,
    this.height = RouteListConfig.height,
    this.itemWidth = RouteListConfig.itemWidth,
    this.sideMargin = AppPaddings.medium,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        clipBehavior: Clip.none,
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
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
        shrinkWrap: true,
      ),
    );
  }
}
