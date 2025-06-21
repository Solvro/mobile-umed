import "dart:async";

import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";
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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_loadData());
  }

  Future<void> _loadData() async {
    // test animacji shimmer
    await fetchRoutes();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchRoutes() async {
    // czas dla animacji shimmer do testów
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.common_finished_routes_title, style: context.textTheme.headlineLarge),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: AppPaddings.tinySmall, vertical: AppPaddings.tinySmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppPaddings.tinySmall),
            SectionHeader(context.l10n.home_nearest_to_you),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: ShimmerConfig.milisecounds500),
              child:
                  isLoading
                      ? const RouteListShimmer(key: ValueKey(ShimmerConfig.shimmerKey))
                      : RouteListWidget(
                        key: const ValueKey(ShimmerConfig.listKey),
                        routes: mockData,
                        onRouteTap: (route) {
                          // TODO(eTraveler04): add action
                        },
                        sideMargin: HomeViewConfig.sideMargin,
                        icon: Icons.arrow_forward_ios,
                      ),
            ),
            const SizedBox(height: HomeViewConfig.commonGap),
            SectionHeader(context.l10n.home_choose_route),
            StartRouteButton(),
            const SizedBox(height: HomeViewConfig.commonGap),
            HomeButtonsRow(),
          ],
        ),
      ),
    );
  }
}

// widget shimmera
class RouteListShimmer extends StatelessWidget {
  const RouteListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.sideMargin),
      child: SizedBox(
        height: RouteListConfig.height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: AppPaddings.tinySmall),
            itemBuilder:
                (_, __) => Container(
                  width: RouteListConfig.itemWidth,
                  height: RouteListConfig.height,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                ),
          ),
        ),
      ),
    );
  }
}
