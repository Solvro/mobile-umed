import "package:flutter/material.dart" hide Route;
import "../../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../models/route.dart";
import "../button_styles.dart";

class RouteCard extends StatelessWidget {
  final Route route;
  final VoidCallback onTap;
  final double width;
  final double height;
  final IconData icon;

  const RouteCard({
    super.key,
    required this.route,
    required this.onTap,
    required this.icon,
    this.width = RouteListConfig.itemWidth,
    this.height = RouteListConfig.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: sharedCardButtonStyle(context, minimumHeight: RouteListConfig.minimumHeightCard, zeroPadding: true),
        onPressed: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.small),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: BottomDiagonalClipper(),
                  child: Container(height: RouteListConfig.clipperHeight, color: context.colorScheme.primary),
                ),
              ),
              Positioned(
                left: AppPaddings.tiny,
                bottom: AppPaddings.tiny,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * 0.90,
                      child: Text(
                        route.name,
                        style: context.textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text("${route.distance} km", style: context.textTheme.labelSmall),
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

class BottomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
