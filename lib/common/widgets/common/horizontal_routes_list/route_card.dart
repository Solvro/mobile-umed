import "package:flutter/material.dart" hide Route;
import "../../../../../app/config/ui_config.dart";
import "../../../../app/config/env.dart";
import "../../../models/route.dart";
import "../../cached_image.dart";

class RouteCard extends StatelessWidget {
  final Route route;
  final VoidCallback onTap;
  final double width;
  final double height;

  const RouteCard({
    super.key,
    required this.route,
    required this.onTap,
    this.width = RouteListConfig.itemWidth,
    this.height = RouteListConfig.height,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.small)),
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.small),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: CachedImage("${Env.apiUrl}assets/${route.image}")),
              Container(
                color: colorScheme.primary,
                padding: const EdgeInsets.all(AppPaddings.tinySmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(route.name, style: textTheme.labelMedium, overflow: TextOverflow.ellipsis, maxLines: 1),
                    Text("${route.distance} km", style: textTheme.labelSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
