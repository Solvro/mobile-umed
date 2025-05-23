import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/arb/app_localizations.g.dart";
import "../../../common/widgets/common/button_styles.dart";

class StartRouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return ElevatedButton(
      style: sharedCardButtonStyle(),
      onPressed: () {
        // TODO: add action "begin you walk"
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: HomeViewConfig.paddingHorizontal,
        ), // wewnętrzny odstęp po bokach

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: HomeViewConfig.buttonInnerHorizontalMargin),
              child: const CircleAvatar(
                radius: HomeViewConfig.circleAvatarRadius,
                backgroundColor: HomeViewConfig.greenIconColor,
                child: Icon(Icons.explore, color: Colors.white, size: HomeViewConfig.exploreIconSize),
              ),
            ),

            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: HomeViewConfig.constrainedTextMaxWidth),
                child: Text(loc.home_start_your_walk, style: HomeViewConfig.buttonTextStyle, textAlign: TextAlign.end),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
