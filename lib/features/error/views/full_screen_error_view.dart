import "package:flutter/material.dart";
import "../../../app/app.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/widgets/buttons/main_action_button.dart";

class FullScreenErrorView extends StatelessWidget {
  final String? message;
  final VoidCallback? onBackToHome;

  const FullScreenErrorView({super.key, this.message, this.onBackToHome});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.medium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, size: ErrorWidgetConfig.iconSize, color: context.colorScheme.error),
            const SizedBox(height: AppPaddings.small),
            Text(context.l10n.errors_title, style: context.textTheme.headlineMedium),
            const SizedBox(height: AppPaddings.small),
            Text(
              message ?? context.l10n.errors_generic,
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppPaddings.medium),
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: ErrorWidgetConfig.buttonOutsidePadding),
              child: MainActionButton(onPressed: onBackToHome ?? context.router.goHome, text: context.l10n.errors_back),
            ),
          ],
        ),
      ),
    );
  }
}
