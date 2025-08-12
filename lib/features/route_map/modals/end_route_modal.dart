import "package:flutter/material.dart" hide Route;
import "../../../app/app.dart";
import "../../../app/config/cached_image_config.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/models/route.dart";
import "../../../common/widgets/buttons/main_action_button.dart";
import "../../../common/widgets/image/cached_image.dart";
import "../../../common/widgets/modals/options_modal.dart";

class EndRouteModal extends StatelessWidget {
  const EndRouteModal({super.key, required this.route});

  final Route route;

  @override
  Widget build(BuildContext context) {
    return OptionsModal(
      title: context.l10n.route_end_modal_title,
      confirmButton: MainActionButton(
        backgroundColor: context.colorScheme.error,
        text: context.l10n.end_route,
        onPressed: () {
          context.router.pop(true);
        },
      ),
      cancelButton: MainActionButton(
        text: context.l10n.keep_going,
        onPressed: () {
          context.router.pop(false);
        },
      ),
      child: Column(
        children: [
          Text(context.l10n.route_end_modal_helper, textAlign: TextAlign.start, overflow: TextOverflow.fade),
          const SizedBox(height: AppPaddings.tinySmall),
          ClipRRect(
            borderRadius: BorderRadius.circular(EndRouteModalConfig.imageRadius),
            child: CachedImage(CachedImageConfig.getDirectusUrl(route.image)),
          ),
        ],
      ),
    );
  }
}
