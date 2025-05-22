import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../app/l10n/l10n.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../app/theme/color_consts.dart";
import "../../../../../common/data_source/mocks/mock_songs.dart";
import "../../../../../common/models/route.dart" as rt;
import "../../../../../common/widgets/secondary_action_button.dart";
import "../../../providers/route_provider.dart";
import "../sections/landmarks_section.dart";
import "../sections/playlist_info_section.dart";
import "route_stat.dart";

class RouteTile extends ConsumerStatefulWidget {
  const RouteTile({super.key, required this.route});

  final rt.Route route;

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

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.route.name, style: context.textTheme.headlineSmall?.copyWith(fontSize: 22)),
                const SizedBox(height: 6),
                Text(widget.route.distance.inKilometers()),
              ],
            ),
          ),
          RouteStat(
            imgPath: "assets/images/water.png",
            comment: widget.route.requiredWater?.inMililiters() ?? context.l10n.ml_0,
          ),
          RouteStat(imgPath: "assets/images/time.png", comment: widget.route.estimatedTime.inMinutes()),
          RouteStat(imgPath: "assets/images/kcal.png", comment: widget.route.calories?.inKcal() ?? context.l10n.kcal_0),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: SecondaryActionButton(onPressed: () {}, text: context.l10n.start_route),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            spacing: BottomSheetHeaderConfig.controlsSpacing,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SecondaryActionButton(
                onPressed: () {
                  setState(() {
                    _chosenOption = RouteDetailsOption.info;
                  });
                },
                text: context.l10n.route_description,
                backgroundColor:
                    _chosenOption != RouteDetailsOption.info ? ColorConsts.whiteGray : ColorConsts.lightGreen,
                textColor: _chosenOption != RouteDetailsOption.info ? ColorConsts.lightGreen : ColorConsts.whiteGray,
              ),

              SecondaryActionButton(
                onPressed: () {
                  setState(() {
                    _chosenOption = RouteDetailsOption.playlist;
                  });
                },
                text: context.l10n.playlist,
                backgroundColor:
                    _chosenOption != RouteDetailsOption.playlist ? ColorConsts.whiteGray : ColorConsts.lightGreen,
                textColor:
                    _chosenOption != RouteDetailsOption.playlist ? ColorConsts.lightGreen : ColorConsts.whiteGray,
              ),
            ],
          ),
        ),
        if (_chosenOption == RouteDetailsOption.info)
          LandmarksSection(landmarks: widget.route.landmarks)
        else
          PlaylistInfoSection(songs: mockSongs),
      ],
    );
  }
}
