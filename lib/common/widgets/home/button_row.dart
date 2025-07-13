import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../app/app.dart";
import "../../../common/widgets/common/vertical_button.dart";
import "../../utils/url_launcher.dart";

class HomeButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.sideMargin),
      child: SizedBox(
        height: VerticalButtonConfig.cardMinimumHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: VerticalButton(
                label: context.l10n.common_finished_routes,
                icon: Icons.auto_graph,
                iconColor: context.colorScheme.primary,
                onPressed: context.router.goProfile,
              ),
            ),
            const SizedBox(width: HomeViewConfig.commonGap),
            Expanded(
              child: VerticalButton(
                label: context.l10n.home_learn_more,
                icon: Icons.public,
                iconColor: context.colorScheme.primary,
                onPressed: () => customLaunchUrl("https://umed.solvro.pl/"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
