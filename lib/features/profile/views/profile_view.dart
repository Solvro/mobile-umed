import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../app/app.dart";
import "../../../common/data_source/mocks/mock_stats.dart";
import "../../../common/models/achievement.dart";
import "../../../common/models/completed_route.dart";
import "../../../common/models/route.dart";
import "../../../common/models/stat.dart";
import "../../../common/parsers/completed_routes_stats_converter.dart";
import "../../../common/widgets/app_bar.dart";
import "../../../common/widgets/horizontal_routes_list/horizontal_routes_list.dart";
import "../../../common/widgets/styling/section_header.dart";
import "../widgets/achivement_description_modal.dart";
import "../widgets/horizontal_stat_card_list/horizontal_card_list.dart";
import "../widgets/progress_bar.dart";

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key, required this.routes, required this.completedRoutes});
  final IList<Route> routes;
  final List<CompletedRoute> completedRoutes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: AppPaddings.tinySmall, bottom: AppPaddings.veryLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppPaddings.medium),
            SectionHeader(context.l10n.common_finished_routes),
            ProgressBar(progress: completedRoutes.length / routes.length),
            if (completedRoutes.isNotEmpty) ...[
              const SizedBox(height: AppPaddings.tiny),
              RouteListWidget(
                routes: routes.where((route) => completedRoutes.map((e) => e.routeId).contains(route.id)).toIList(),
                onRouteTap: (route) => context.router.pushRouteMap(route.id),
                icon: Icons.autorenew,
              ),
            ],
            const SizedBox(height: AppPaddings.medium),
            SectionHeader(context.l10n.achievements_statistics),
            StatListWidget<Stat>(stats: convertCompletedRoutesToStats(completedRoutes)),
            const SizedBox(height: AppPaddings.medium),
            if (kDebugMode) ...[
              SectionHeader(context.l10n.achievements_achievements),
              const SizedBox(height: AppPaddings.tinySmall),
              StatListWidget<Achievement>(
                stats: mockAchievements,
                onTap:
                    (stat) async => showDialog(
                      context: context,
                      builder: (context) => AchievementDescriptionModal(achievement: stat),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
