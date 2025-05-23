import "package:flutter/material.dart";
import "../../models/route.dart" as app_route;
import "button_styles.dart";

class RouteListWidget extends StatelessWidget {
  final List<app_route.Route> routes;
  final void Function(app_route.Route) onRouteTap;
  final double height;
  final double itemWidth;

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
          final imageUrl = "https://picsum.photos/seed/${route.id}/300/200";

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
                    // tło obrazka
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey)),
                    ),
                    // gradient + name
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
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
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
