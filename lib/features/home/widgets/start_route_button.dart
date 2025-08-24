import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../app/app.dart";
import "../../../common/widgets/styling/button_styles.dart";

class StartRouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium),
      child: ElevatedButton(
        style: sharedCardButtonStyle(context),
        onPressed: context.router.pushMultiRouteMap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppPaddings.tiny),
                child: CircleAvatar(
                  radius: HomeViewConfig.circleAvatarRadius,
                  backgroundColor: context.colorScheme.primary,
                  child: Icon(
                    Icons.explore,
                    color: context.colorScheme.onSecondary,
                    size: HomeViewConfig.exploreIconSize,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: HomeViewConfig.constrainedTextMaxWidth),
                child: Text(
                  context.l10n.home_start_your_walk,
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
