import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../app/app.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/data_source/mocks/mock_stats.dart";
import "../../../common/models/route.dart";
import "../../../common/parsers/completed_routes_stats_converter.dart";
import "../../../common/providers/completed_routes_provider.dart";
import "../../../common/widgets/common/horizontal_routes_list/horizontal_routes_list.dart";
import "../../../common/widgets/common/section_header.dart";
import "../../../common/widgets/profile/horizontal_stat_card_list/horizontal_card_list.dart";
import "../../../common/widgets/profile/progress_bar.dart";

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key, required this.routes});
  final IList<Route> routes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedRoutes = ref.watch(completedRoutesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.common_finished_routes_title, style: context.textTheme.headlineLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.tinySmall, vertical: AppPaddings.tinySmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppPaddings.medium),
            SectionHeader(context.l10n.common_finished_routes),
            const ProgressBar(progress: 0.67123),
            const SizedBox(height: AppPaddings.tiny),
            RouteListWidget(
              routes: routes,
              onRouteTap: (route) => context.router.pushRouteMapWithRoute(route.id),
              sideMargin: ProfileViewConfig.sideMargin,
              icon: Icons.autorenew,
            ),
            const SizedBox(height: AppPaddings.medium),
            SectionHeader(context.l10n.achievements_statistics),
            switch (completedRoutes) {
              AsyncData(:final value) => StatListWidget(stats: convertCompletedRoutesToStats(value)),
              AsyncLoading() => const Center(child: CircularProgressIndicator()),
              _ => Center(child: Text(context.l10n.errors_stats)),
            },
            const SizedBox(height: AppPaddings.medium),
            SectionHeader(context.l10n.achievements_achievements),
            const SizedBox(height: AppPaddings.tinySmall),
            StatListWidget(stats: mockAchievements),
          ],
        ),
      ),
    );
  }
}
