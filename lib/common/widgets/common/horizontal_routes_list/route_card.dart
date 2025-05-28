import "package:flutter/material.dart" hide Route;
import "../../../../../app/config/ui_config.dart";
import "../../../models/route.dart";
import "../button_styles.dart";

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
                          color: AppColors.errorColor,
                        ),
                      ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.transparent, AppColors.black45],
                  ),
                ),
                padding: const EdgeInsets.all(AppPaddings.tiny),
                child: Text(route.name, style: RouteListConfig.titleTextStyle, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
