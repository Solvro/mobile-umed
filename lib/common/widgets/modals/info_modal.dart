import "package:flutter/material.dart";
import "../../../app/app.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../buttons/main_action_button.dart";

class InfoModal extends StatelessWidget {
  const InfoModal({
    super.key,
    required this.title,
    required this.child,
    this.backButtonText,
    this.onClose,
    this.decoration,
  });

  final String title;
  final Widget child;
  final String? backButtonText;
  final VoidCallback? onClose;
  final Widget? decoration;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.medium,
        vertical: InfoModalConfig.outerPaddingVertical,
      ),
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(InfoModalConfig.radius)),
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.small),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (decoration != null)
              Positioned(
                top: 0,
                right: 0,
                child: Opacity(opacity: InfoModalConfig.decorationOpacity, child: decoration),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.headlineMedium),
                const SizedBox(height: AppPaddings.tinySmall),
                Flexible(child: child),

                MainActionButton(
                  text: backButtonText ?? context.l10n.close,
                  onPressed: onClose ?? () => context.router.pop(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
