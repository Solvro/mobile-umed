import "package:flutter/material.dart";
import "../../../app/app.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/widgets/main_action_button.dart";
import "../../../common/widgets/options_modal.dart";
import "stat_info_compact.dart";

class RouteCompletedModal extends StatelessWidget {
  const RouteCompletedModal({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionsModal(
      title: context.l10n.route_completed_modal_title,
      confirmButton: MainActionButton(
        backgroundColor: context.colorScheme.error,
        text: context.l10n.route_completed_back_to_menu,
        onPressed: () {
          while (context.router.canPop()) {
            context.router.pop();
          }
        },
      ),
      cancelButton: MainActionButton(
        text: context.l10n.route_completed_keep_browsing,
        onPressed: () {
          context.router.pop();
        },
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.route_completed_modal_helper, style: context.textTheme.bodyLarge),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          Text(context.l10n.stats, style: context.textTheme.headlineMedium),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),

          Row(
            spacing: RouteCompleteModalConfig.horizontalSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.covered_distance,
                  value: "8,250",
                  icon: Icons.social_distance_outlined,
                  color: RouteCompleteModalConfig.distanceInfoColor,
                ),
              ),
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.burnt_calories,
                  value: "540 kcal",
                  icon: Icons.local_fire_department,
                  color: RouteCompleteModalConfig.caloriesInfoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          // Second Row
          Row(
            spacing: RouteCompleteModalConfig.horizontalSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.time,
                  value: "6.2 km",
                  icon: Icons.timer_outlined,
                  color: RouteCompleteModalConfig.timeInfoColor,
                ),
              ),
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.avg_pace,
                  value: "78 bpm",
                  icon: Icons.speed_outlined,
                  color: RouteCompleteModalConfig.paceInfoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          Text(context.l10n.achievements, style: context.textTheme.headlineMedium),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
        ],
      ),
    );
  }
}
