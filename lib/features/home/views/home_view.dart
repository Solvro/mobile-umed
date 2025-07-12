import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/widgets/common/horizontal_routes_list/horizontal_routes_list.dart";
import "../../../common/widgets/common/section_header.dart";
import "../../../common/widgets/home/button_row.dart";
import "../../../common/widgets/home/start_route_button.dart";
import "./../../../common/data_source/mocks/mock_routes.dart";

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key, required this.title});
  final String title;

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
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
          RouteListWidget(
            routes: mockData,
            onRouteTap: (route) {
              // TODO(eTraveler04): add action
            },
            sideMargin: HomeViewConfig.sideMargin,
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
