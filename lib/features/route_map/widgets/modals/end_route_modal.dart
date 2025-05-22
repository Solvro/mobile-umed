import "package:flutter/material.dart";

import "../../../../app/app.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/widgets/cached_image.dart";
import "../../../../common/widgets/main_action_button.dart";
import "../../../../common/widgets/options_modal.dart";

class EndRouteModal extends StatelessWidget {
  const EndRouteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionsModal(
      title: context.l10n.route_end_modal_title,
      confirmButton: MainActionButton(
        backgroundColor: context.colorScheme.error,
        text: context.l10n.end_route,
        onPressed: () {
          context.router.pop();
          context.router.pop();
        },
      ),
      cancelButton: MainActionButton(text: context.l10n.keep_going, onPressed: context.router.pop),
      child: Column(
        children: [
          Text(context.l10n.route_end_modal_helper, textAlign: TextAlign.start, overflow: TextOverflow.fade),
          const SizedBox(height: AppPaddings.tinySmall),
          // Image placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(EndRouteModalConfig.imageRadius),
            child: const CachedImage(
              //for now there is no image url property in the landmark model
              "https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg",
            ),
          ),
        ],
      ),
    );
  }
}
