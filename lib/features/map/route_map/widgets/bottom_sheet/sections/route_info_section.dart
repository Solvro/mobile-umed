import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../../app/config/ui_config.dart";
import "../../../../../../app/theme/app_theme.dart";
import "../../../controllers/route_controller.dart";

class RouteInfoSection extends ConsumerWidget {
  const RouteInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(routeTimerProvider);
    final distance = ref.watch(distanceProvider);
    final speed = ref.watch(speedProvider);

    return Container(
      padding: const EdgeInsets.all(RouteInfoConfig.contentPadding),
      child: Column(
        spacing: RouteInfoConfig.verticalSpacing,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InformationBox(text: timer.toHmsString(), color: context.colorScheme.primary),
          Row(
            spacing: RouteInfoConfig.infoBubbleSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _InformationBox(text: distance.toDistanceString(), color: context.colorScheme.primary)),
              Expanded(child: _InformationBox(text: "$speed km/h", color: context.colorScheme.primary)),
            ],
          ),
        ],
      ),
    );
  }
}

extension DurationFormatting on Duration {
  String toHmsString() {
    final hours = inHours;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;
    return "${hours.toString().padLeft(2, '0')}:"
        "${minutes.toString().padLeft(2, '0')}:"
        "${seconds.toString().padLeft(2, '0')}";
  }
}

extension DistanceFormatting on int {
  String toDistanceString() {
    if (this < 1000) {
      return "$this m";
    } else {
      return "${(this / 1000).toStringAsFixed(1)} km";
    }
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
