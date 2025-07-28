import "dart:collection";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../app/assets/assets.gen.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../app/l10n/l10n.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../app/theme/color_consts.dart";
import "../../../../../common/data_source/mocks/mock_songs.dart";
import "../../../../../common/models/route.dart";
import "../../../../../common/widgets/secondary_action_button.dart";
import "../../../modals/start_route_modal.dart";
import "../../../providers/route_provider.dart";
import "../sections/landmarks_section.dart";
import "../sections/playlist_info_section.dart";
import "route_stat.dart";

class RouteTile extends ConsumerStatefulWidget {
  const RouteTile({super.key, required this.route});

  final Route route;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RouteTileState();
}

class RouteTileState extends ConsumerState<RouteTile> {
  late RouteDetailsOption _chosenOption;

  @override
  void initState() {
    super.initState();
    _chosenOption = RouteDetailsOption.info;
  }

  void updateExpandedRoutes(Route route, {bool shouldDelete = false}) {
    final currentSelectedRoutes = ref.read(expandedRoutesProvider);
    final updatedRoutes = LinkedHashSet<Route>.from(currentSelectedRoutes);
    updatedRoutes.remove(route);
    if (!shouldDelete) {
      updatedRoutes.add(route);
    }
    ref.read(expandedRoutesProvider.notifier).state = updatedRoutes;
  }

  @override
  Widget build(BuildContext context) {
    final route = widget.route;

    return ExpansionTile(
      onExpansionChanged: (isExpanding) => updateExpandedRoutes(route, shouldDelete: !isExpanding),
      title: Row(
        spacing: AppPaddings.nano,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(route.name, style: context.textTheme.headlineSmall?.copyWith(fontSize: 22)),
                const SizedBox(height: 6),
                Text(route.distance.inKilometers()),
              ],
            ),
          ),
          RouteStat(
            icon: Assets.icons.water.svg(width: SelectRouteConfig.iconSize, height: SelectRouteConfig.iconSize),
            comment: (route.waterDemand ?? 0).inMilliliters(),
          ),
          if (route.estimatedTime != null)
            RouteStat(
              icon: Assets.icons.time.svg(width: SelectRouteConfig.iconSize, height: SelectRouteConfig.iconSize),
              comment: route.estimatedTime!.inMinutes(),
            ),
          if (route.calories != null)
            RouteStat(
              icon: Assets.icons.kcal.svg(width: SelectRouteConfig.iconSize, height: SelectRouteConfig.iconSize),
              comment: (route.calories ?? 0).inKcal(),
            ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPaddings.tinySmall),
          child: SecondaryActionButton(
            onPressed: () async {
              await showDialog<StartRouteModal>(context: context, builder: (context) => StartRouteModal(route: route));
            },
            text: context.l10n.start_route,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddings.tinySmall),
          child: Row(
            spacing: BottomSheetHeaderConfig.controlsSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: SecondaryActionButton(
                  onPressed: () {
                    updateExpandedRoutes(route);
                    setState(() => _chosenOption = RouteDetailsOption.info);
                  },
                  text: context.l10n.route_description,
                  backgroundColor:
                      _chosenOption != RouteDetailsOption.info ? ColorConsts.whiteGray : ColorConsts.plumosa,
                  textColor: _chosenOption != RouteDetailsOption.info ? ColorConsts.plumosa : ColorConsts.whiteGray,
                ),
              ),
              Expanded(
                child: SecondaryActionButton(
                  onPressed: () {
                    updateExpandedRoutes(route);
                    setState(() => _chosenOption = RouteDetailsOption.playlist);
                  },
                  text: context.l10n.playlist,
                  backgroundColor:
                      _chosenOption != RouteDetailsOption.playlist ? ColorConsts.whiteGray : ColorConsts.plumosa,
                  textColor: _chosenOption != RouteDetailsOption.playlist ? ColorConsts.plumosa : ColorConsts.whiteGray,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppPaddings.small),
        if (_chosenOption == RouteDetailsOption.info)
          LandmarksSection(checkpoints: route.checkpoints)
        else
          PlaylistInfoSection(songs: mockSongs),
      ],
    );
  }
}
