import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../../../../../app/app.dart";
import "../../../../../app/l10n/l10n.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../common/models/route.dart";
import "../../../../../common/widgets/main_action_button.dart";
import "../../../../../common/widgets/options_modal.dart";
import "../../../../app/theme/color_consts.dart";
import "../../../../common/providers/bottom_sheet_providers.dart";
import "../providers/route_provider.dart";

class StartRouteModal extends ConsumerWidget {
  const StartRouteModal({super.key, required this.route});

  final Route route;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OptionsModal(
      title: context.l10n.start_route_modal_title(route.name),
      confirmButton: MainActionButton(
        // backgroundColor: context.colorScheme.error,
        backgroundColor: ColorConsts.whiteGray,
        textColor: ColorConsts.dimGray,
        text: context.l10n.keep_on_browsing,
        onPressed: () => context.pop(),
      ),
      cancelButton: MainActionButton(
        text: context.l10n.start,
        onPressed: () {
          ref.read(routeProvider.notifier).state = route;
          ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
          ref.read(selectedRouteProvider.notifier).state = null;
          context.router.pop();
        },
      ),
      child: Text(
        route.description,
        textAlign: TextAlign.start,
        style: context.textTheme.bodyMedium?.copyWith(fontSize: 14),
      ),
    );
  }
}
