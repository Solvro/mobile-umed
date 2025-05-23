import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../common/widgets/common/horizontal_routes_list.dart";
import "../../../common/widgets/common/section_header.dart";
import "../../../common/widgets/home/button_row.dart";
import "../../../common/widgets/home/start_route_button.dart";
import "./../../../app/l10n/arb/app_localizations.g.dart";
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
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.common_finished_routes_title, style: HomeViewConfig.appBarTextStyle),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: HomeViewConfig.paddingHorizontal,
          vertical: HomeViewConfig.paddingVertical,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: HomeViewConfig.paddingVertical),
            SectionHeader(loc.home_nearest_to_you),
            RouteListWidget(
              key: const ValueKey("mockRoutesList"),
              routes: mockData,
              onRouteTap: (route) {
                // TODO: add action
              },
            ),
            const SizedBox(height: HomeViewConfig.commonGap),
            SectionHeader(loc.home_choose_route),
            StartRouteButton(),
            const SizedBox(height: HomeViewConfig.commonGap),
            HomeButtonsRow(),
          ],
        ),
      ),
    );
  }
}
