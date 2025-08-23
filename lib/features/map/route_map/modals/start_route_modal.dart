import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../../app/app.dart";
import "../../../../../../app/l10n/l10n.dart";
import "../../../../../../app/theme/app_theme.dart";
import "../../../../../../common/models/route.dart";
import "../../../../../app/theme/color_consts.dart";
import "../../../../../common/providers/bottom_sheet_providers.dart";
import "../../../../app/config/cached_image_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../common/widgets/buttons/main_action_button.dart";
import "../../../../common/widgets/image/cached_image.dart";
import "../../../../common/widgets/modals/options_modal.dart";
import "../providers/route_provider.dart";

class StartRouteModal extends ConsumerWidget {
  const StartRouteModal({super.key, required this.route});

  final Route route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OptionsModal(
      title: route.name,
      confirmButton: MainActionButton(
        backgroundColor: ColorConsts.whiteGray,
        textColor: ColorConsts.dimGray,
        text: context.l10n.keep_on_browsing,
        onPressed: () {
          ref.read(routeProvider.notifier).state = route;
          ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
          context.router.pop();
        },
      ),
      cancelButton: MainActionButton(text: context.l10n.start, onPressed: () => context.router.pushRouteMap(route.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppPaddings.small,
        children: [
          Text(
            route.description != null ? route.description! : context.l10n.start_route_modal_title,
            textAlign: TextAlign.start,
            style: context.textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
          Expanded(child: Center(child: CachedImage(CachedImageConfig.getDirectusUrl(route.image)))),
          const SizedBox(height: AppPaddings.tinySmall),
        ],
      ),
    );
  }
}
