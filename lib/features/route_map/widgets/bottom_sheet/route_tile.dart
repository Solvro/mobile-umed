import "package:flutter/material.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/route.dart" as rt;
import "route_stat.dart";

class RouteTile extends StatelessWidget {
  const RouteTile({super.key, required this.route});

  final rt.Route route;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(route.name, style: context.textTheme.headlineSmall?.copyWith(fontSize: 22)),
                const SizedBox(height: 8),
                Text(route.distance.inKilometers()),
              ],
            ),
          ),
          RouteStat(
            imgPath: "assets/images/water.png",
            comment: route.requiredWater?.inMililiters() ?? context.l10n.ml_0,
          ),
          RouteStat(imgPath: "assets/images/time.png", comment: route.estimatedTime.inMinutes()),
          RouteStat(imgPath: "assets/images/kcal.png", comment: route.calories?.inKcal() ?? context.l10n.kcal_0),
        ],
      ),
    );
  }
}
