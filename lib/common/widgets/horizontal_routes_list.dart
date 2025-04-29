import "package:flutter/material.dart";
import "../models/test_routes_list.dart";
import "./home_view_styles.dart";

class RouteListWidget extends StatelessWidget {
  /// List of routes do disply
  final List<RouteItem> routes;

  /// Width of a widget(default 190)
  final double height;

  /// Width of a single item (default 150)
  final double itemWidth;

  /// What happens after the Tap
  final void Function(RouteItem route) onRouteTap;

  const RouteListWidget({
    super.key,
    required this.routes,
    required this.onRouteTap,
    this.height = 190,
    this.itemWidth = 150,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: routes.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final route = routes[index];
          return SizedBox(
            key: ValueKey(route.id),
            width: itemWidth,
            child: ElevatedButton(
              style: sharedCardButtonStyle(minimumHeight: 120, zeroPadding: true),
              onPressed: () => onRouteTap(route),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      route.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black45],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                      child: Text(
                        route.name,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
