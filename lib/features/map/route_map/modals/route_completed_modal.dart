import "package:flutter/material.dart" hide Route;
import "../../../../app/app.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/extensions/double_ext.dart";
import "../../../../common/extensions/duration_ext.dart";
import "../../../../common/extensions/int_ext.dart";
import "../../../../common/models/route.dart";
import "../../../../common/widgets/buttons/main_action_button.dart";
import "../../../../common/widgets/modals/options_modal.dart";
import "../../../home/home_page.dart";
import "stat_info_compact.dart";

class RouteCompletedModal extends StatelessWidget {
  const RouteCompletedModal({super.key, required this.route, required this.time});

  final Route route;
  final Duration time;
  @override
  Widget build(BuildContext context) {
    return OptionsModal(
      title: context.l10n.route_completed_modal_title,
      confirmButton: MainActionButton(
        backgroundColor: context.colorScheme.error,
        text: context.l10n.route_completed_back_to_menu,
        onPressed: () {
          context.router.go(HomePage.routeName);
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
                  value: route.distance.inKilometers(),
                  icon: Icons.social_distance_outlined,
                  color: RouteCompleteModalConfig.distanceInfoColor,
                ),
              ),
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.burnt_calories,
                  value: (route.calories ?? 0).inKcal(),
                  icon: Icons.local_fire_department,
                  color: RouteCompleteModalConfig.caloriesInfoColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: RouteCompleteModalConfig.verticalSpacing),
          Row(
            spacing: RouteCompleteModalConfig.horizontalSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.time,
                  value: time.toHmsString(),
                  icon: Icons.timer_outlined,
                  color: RouteCompleteModalConfig.timeInfoColor,
                ),
              ),
              Expanded(
                child: StatInfoCompact(
                  title: context.l10n.avg_pace,
                  value:
                      route.distance > 0 && time.inHours > 0
                          ? "${(route.distance / (time.inMinutes / 60)).toStringAsFixed(2)} km/h"
                          : "-",
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
