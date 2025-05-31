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

  const RouteCard({
    super.key,
    required this.route,
    required this.onTap,
    this.width = RouteListConfig.itemWidth,
    this.height = RouteListConfig.height,
  });

  @override
  Widget build(BuildContext context) {
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
              Container(color: context.colorScheme.onSecondary),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: TopRightTriangleClipper(),
                  child: Container(height: RouteListConfig.clipperHeight, color: context.colorScheme.secondary),
                ),
              ),
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
                    Text(route.name, style: context.textTheme.labelMedium),
                    Text("${route.distance} km", style: context.textTheme.labelSmall),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: AppPaddings.tiny, bottom: AppPaddings.tinySmall),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: context.colorScheme.secondary,
                    size: RouteListConfig.arrowIconSize,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TopRightTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width - 30, 0);
    path.lineTo((size.width / 2) + 25, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BottomDiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, 0);
    path.lineTo((size.width / 2) + 25, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
