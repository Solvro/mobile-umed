import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/widgets/common/section_header.dart";
import "../../../common/widgets/shimmer/horizontal_list_shimmer.dart";

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.common_finished_routes_title, style: context.textTheme.headlineLarge),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.tinySmall, vertical: AppPaddings.tinySmall),
        children: [
          const SizedBox(height: AppPaddings.tinySmall),
          SectionHeader(context.l10n.home_nearest_to_you),
          const RouteListShimmer(),
          const SizedBox(height: HomeViewConfig.commonGap),
          SectionHeader(context.l10n.home_choose_route),
          const RouteListShimmer(),
          const SizedBox(height: HomeViewConfig.commonGap),
        ],
      ),
    );
  }
}
