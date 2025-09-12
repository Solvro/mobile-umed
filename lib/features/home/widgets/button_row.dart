import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../app/app.dart";
import "../../../common/providers/progress_provider.dart";
import "../../../common/utils/url_launcher.dart";
import "../../../common/widgets/buttons/vertical_button.dart";
import "../../../common/widgets/progress/circular_progress.dart";

class HomeButtonsRow extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium),
      child: SizedBox(
        height: VerticalButtonConfig.cardMinimumHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: () {
                final progressAsync = ref.watch(routeProgressProvider);

                return switch (progressAsync) {
                  AsyncData(:final value) => VerticalButton(
                    label: context.l10n.common_finished_routes,
                    customWidget: CircularProgressWithText(
                      progress: value,
                      size: VerticalButtonConfig.iconSize - CircularProgressConfig.strokeWidth,
                      strokeWidth: CircularProgressConfig.strokeWidth,
                      backgroundColor: context.colorScheme.primary.withValues(
                        alpha: CircularProgressConfig.backgroundAlpha,
                      ),
                      progressGradient: CircularProgressConfig.createProgressGradient(context.colorScheme),
                      textStyle: CircularProgressConfig.createProgressTextStyle(
                        context.colorScheme,
                        context.textTheme.labelLarge,
                      ),
                    ),
                    onPressed: context.router.goProfile,
                  ),
                  AsyncError() => VerticalButton(
                    label: context.l10n.common_finished_routes,
                    icon: Icons.wifi_off,
                    iconColor: Colors.grey,
                    onPressed: context.router.goProfile,
                  ),
                  _ => VerticalButton(
                    label: context.l10n.common_finished_routes,
                    icon: Icons.auto_graph,
                    iconColor: context.colorScheme.primary,
                    onPressed: context.router.goProfile,
                  ),
                };
              }(),
            ),
            const SizedBox(width: HomeViewConfig.commonGap),
            Expanded(
              child: VerticalButton(
                label: context.l10n.home_learn_more,
                icon: Icons.public,
                iconColor: context.colorScheme.primary,
                onPressed: () => customLaunchUrl("https://pierwszeskrzypce.umw.edu.pl/"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
