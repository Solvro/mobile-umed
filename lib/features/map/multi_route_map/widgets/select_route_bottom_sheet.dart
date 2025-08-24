import "dart:async";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart" hide Route;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/color_consts.dart";
import "../../../../common/models/route.dart";
import "../../../../common/providers/bottom_sheet_providers.dart";
import "../../../../common/widgets/buttons/main_action_button.dart";
import "../../../../common/widgets/map_bottom_sheet.dart";
import "../../route_map/widgets/bottom_sheet/tiles/route_tile.dart";

class SelectRouteBottomSheet extends ConsumerStatefulWidget {
  const SelectRouteBottomSheet({super.key, required this.routes});
  final IList<Route> routes;

  @override
  SelectRouteBottomSheetState createState() => SelectRouteBottomSheetState();
}

class SelectRouteBottomSheetState extends ConsumerState<SelectRouteBottomSheet> {
  @override
  void initState() {
    super.initState();
    unawaited(
      Future.microtask(() {
        ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final routes = widget.routes;

    return MapBottomSheet(
      button: MainActionButton(
        text: context.l10n.browse_routes,
        onPressed: () {
          if (ref.read(sheetStateProvider) == SheetState.hidden) {
            ref.read(sheetStateProvider.notifier).state = SheetState.visible;
          } else {
            ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
          }
        },
      ),
      child: Container(
        padding: const EdgeInsets.all(SelectRouteConfig.contentPadding),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1, color: ColorConsts.mistGray),
          itemCount: routes.length,
          itemBuilder: (context, index) => RouteTile(route: routes[index]),
        ),
      ),
    );
  }
}
