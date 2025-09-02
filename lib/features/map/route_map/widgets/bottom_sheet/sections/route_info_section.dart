import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../../app/config/ui_config.dart";
import "../../../../../../app/theme/app_theme.dart";
import "../../../../../../common/extensions/duration_ext.dart";
import "../../../../../../common/extensions/int_ext.dart";
import "../../../providers/route_stats_provider.dart";

class RouteInfoSection extends ConsumerWidget {
  const RouteInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeStats = ref.watch(routeStatsProvider);

    final speed =
        routeStats.elapsed.inSeconds == 0
            ? 0
            : (routeStats.distance / routeStats.elapsed.inSeconds) * 3.6; // speed in km/h s

    return Container(
      padding: const EdgeInsets.all(RouteInfoConfig.contentPadding),
      child: Column(
        spacing: RouteInfoConfig.verticalSpacing,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InformationBox(text: routeStats.elapsed.toHmsString(), color: context.colorScheme.primary),
          Row(
            spacing: RouteInfoConfig.infoBubbleSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _InformationBox(
                  text: routeStats.distance.toDistanceString(),
                  color: context.colorScheme.primary,
                ),
              ),
              Expanded(
                child: _InformationBox(text: "${speed.toStringAsFixed(1)} km/h", color: context.colorScheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InformationBox extends StatelessWidget {
  final String text;
  final Color color;

  const _InformationBox({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: RouteInfoConfig.infoBubbleMinHeight),
      alignment: Alignment.center,
      decoration: _decoration(color), // keep this private method in same file
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  static BoxDecoration _decoration(Color color) {
    return BoxDecoration(
      border: Border.all(color: color, width: 2),
      borderRadius: const BorderRadius.all(Radius.circular(RouteInfoConfig.infoBubbleRoundedRad)),
    );
  }
}
