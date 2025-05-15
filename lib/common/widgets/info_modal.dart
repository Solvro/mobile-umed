import "package:flutter/material.dart";
import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";
import "main_action_button.dart";

class InfoModal extends StatelessWidget {
  const InfoModal({super.key, required this.title, required this.child, this.onClose});

  final String title;
  final Widget child;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: InfoModalConfig.outerPaddingHorizontal,
        vertical: InfoModalConfig.outerPaddingVertical,
      ),
      backgroundColor: context.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(InfoModalConfig.radius)),
      child: Padding(
        padding: const EdgeInsets.all(InfoModalConfig.innerPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fit to content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),

            const SizedBox(height: InfoModalConfig.titleSpacer),
            Expanded(child: child),

            MainActionButton(text: "Zamknij", onPressed: onClose ?? () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}
