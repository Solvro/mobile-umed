import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../models/route.dart" as app_route;
import "../button_styles.dart";

/// A single route card for horizontal lists in the app.
class RouteCard extends StatelessWidget {
  final app_route.Route route;
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
    final imageUrl = "https://picsum.photos/seed/${route.id}/300/200";

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: sharedCardButtonStyle(minimumHeight: RouteListConfig.minimumHeightCard, zeroPadding: true),
        onPressed: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(RouteListConfig.borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image with semantics
              Semantics(
                label: "image for ${route.name}",
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: RouteListConfig.errorIconSize,
                          color: RouteListConfig.errorIconColor,
                        ),
                      ),
                ),
              ),
              // Gradient overlay and title
              Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black45],
                  ),
                ),
                padding: const EdgeInsets.all(RouteListConfig.titlePadding),
                child: Text(route.name, style: RouteListConfig.titleTextStyle, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
