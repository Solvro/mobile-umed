import "package:flutter/material.dart";
import "../../app/config/ui_config.dart";
import "../../app/theme/app_theme.dart";
import "main_action_button.dart";

class InfoModal extends StatelessWidget {
  const InfoModal({super.key, required this.title, required this.child, this.onClose, this.decoration});

  final String title;
  final Widget child;
  final VoidCallback? onClose;
  final Widget? decoration;

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
                const SizedBox(height: InfoModalConfig.titleSpacer),
                Flexible(child: child),

                MainActionButton(text: "Zamknij", onPressed: onClose ?? () => Navigator.of(context).pop()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
