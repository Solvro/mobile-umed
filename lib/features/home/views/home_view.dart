import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../app/app.dart";
import "../../../common/models/route.dart";
import "../../../common/widgets/app_bar.dart";
import "../../../common/widgets/horizontal_routes_list/horizontal_routes_list.dart";
import "../../../common/widgets/styling/section_header.dart";
import "../widgets/button_row.dart";
import "../widgets/start_route_button.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.routes});

  final IList<Route> routes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.common_app_bar_title_one,
        subtitle: context.l10n.common_app_bar_title_two,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
            top: AppPaddings.tinySmall, bottom: AppPaddings.veryLarge),
        children: [
          const SizedBox(height: AppPaddings.tinySmall),
          SectionHeader(context.l10n.home_nearest_to_you),
          RouteListWidget(
            routes: routes,
            onRouteTap: (route) => context.router.pushRouteMap(id: route.id),
            icon: Icons.arrow_forward_ios,
          ),
          const SizedBox(height: HomeViewConfig.commonGap),
          SectionHeader(context.l10n.home_choose_route),
          StartRouteButton(),
          const SizedBox(height: HomeViewConfig.commonGap),
          HomeButtonsRow(),
        ],
      ),
    );
  }
}
