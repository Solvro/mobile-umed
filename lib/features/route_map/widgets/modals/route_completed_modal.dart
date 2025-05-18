import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/widgets/info_modal.dart";
import "stat_info_compact.dart";

class RouteCompletedModal extends StatelessWidget {
  const RouteCompletedModal({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoModal(
      title: "Gratulacje!",
      decoration: SvgPicture.asset(
        "assets/icons/checkmark.svg",
        width: RouteCompleteModalConfig.decorationSize,
        height: RouteCompleteModalConfig.decorationSize,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ukonczyles trase, mozesz byc z siebie dumny", style: context.textTheme.bodyLarge),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          Text("Statystyki", style: context.textTheme.headlineMedium),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),

          const Row(
            spacing: RouteCompleteModalConfig.horizontalSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatInfoCompact(
                  title: "Przebyta odległość",
                  value: "8,250",
                  icon: Icons.social_distance_outlined,
                  color: RouteCompleteModalConfig.distanceInfoColor,
                ),
              ),
              Expanded(
                child: StatInfoCompact(
                  title: "Spalone",
                  value: "540 kcal",
                  icon: Icons.local_fire_department,
                  color: RouteCompleteModalConfig.caloriesInfoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          // Second Row
          const Row(
            spacing: RouteCompleteModalConfig.horizontalSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatInfoCompact(
                  title: "Czas",
                  value: "6.2 km",
                  icon: Icons.timer_outlined,
                  color: RouteCompleteModalConfig.timeInfoColor,
                ),
              ),
              Expanded(
                child: StatInfoCompact(
                  title: "Tempo",
                  value: "78 bpm",
                  icon: Icons.speed_outlined,
                  color: RouteCompleteModalConfig.paceInfoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          Text("Zdobyte osiagniecia", style: context.textTheme.headlineMedium),
        ],
      ),
    );
  }
}
