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
              child: Consumer(
                builder: (context, ref, child) {
                  final progressAsync = ref.watch(routeProgressProvider);
                  return progressAsync.when(
                    data:
                        (progress) => VerticalButton(
                          label: context.l10n.common_finished_routes,
                          customWidget: CircularProgressWithText(
                            progress: progress,
                            size: 75,
                            strokeWidth: 8,
                            backgroundColor: context.colorScheme.primary.withValues(alpha: 0.2),
                            progressGradient: LinearGradient(
                              colors: [
                                context.colorScheme.primary,
                                context.colorScheme.secondary,
                                context.colorScheme.error,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            textStyle: context.textTheme.labelLarge?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: context.router.goProfile,
                        ),
                    loading:
                        () => VerticalButton(
                          label: context.l10n.common_finished_routes,
                          icon: Icons.auto_graph,
                          iconColor: context.colorScheme.primary,
                          onPressed: context.router.goProfile,
                        ),
                    error:
                        (error, stack) => VerticalButton(
                          label: context.l10n.common_finished_routes,
                          icon: Icons.wifi_off,
                          iconColor: Colors.grey,
                          onPressed: context.router.goProfile,
                        ),
                  );
                },
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
