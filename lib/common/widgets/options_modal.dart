import "package:flutter/material.dart";
import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";
import "main_action_button.dart";

class OptionsModal extends StatelessWidget {
  const OptionsModal({
    super.key,
    required this.title,
    required this.child,
    required this.confirmButton,
    required this.cancelButton,
  });

  final String title;
  final Widget child;
  final MainActionButton confirmButton;
  final MainActionButton cancelButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.horizontalMedium,
        vertical: OptionsModalConfig.outerPaddingVertical,
      ),
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(OptionsModalConfig.radius)),
      child: Padding(
        padding: const EdgeInsets.all(AppPaddings.inner),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.headlineMedium),
            const SizedBox(height: OptionsModalConfig.titleSpacer),
            Expanded(child: child),
            cancelButton,
            confirmButton,
          ],
        ),
      ),
    );
  }
}
