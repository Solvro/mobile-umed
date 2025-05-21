import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../app/theme/color_consts.dart";
import "../../../../common/data_source/mocks/mock_routes.dart";
import "../../../../common/providers/bottom_sheet_providers.dart";
import "../../../../common/widgets/main_action_button.dart";
import "../../../../common/widgets/map_bottom_sheet.dart";
import "route_tile.dart";

class ChooseRouteBottomSheet extends ConsumerStatefulWidget {
  @override
  ChooseRouteBottomSheetState createState() => ChooseRouteBottomSheetState();
}

class ChooseRouteBottomSheetState extends ConsumerState<ChooseRouteBottomSheet> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(sheetModeProvider.notifier).state = SheetMode.expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MapBottomSheet(
      button: MainActionButton(text: context.l10n.start_route, onPressed: () async {}),
      child: Container(
        padding: const EdgeInsets.all(SelectRouteConfig.contentPadding),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1, color: ColorConsts.mistGray),
          itemCount: mockData.length,
          itemBuilder: (context, index) {
            return RouteTile(route: mockData[index]);
          },
        ),
      ),
    );
  }
}
