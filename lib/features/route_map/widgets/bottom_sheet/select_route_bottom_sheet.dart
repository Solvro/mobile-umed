import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/l10n/l10n.dart";
import "../../../../common/data_source/mocks/mock_routes.dart";
import "../../../../common/widgets/main_action_button.dart";
import "../../../../common/widgets/map_bottom_sheet.dart";

class ChooseRouteBottomSheet extends ConsumerStatefulWidget {
  @override
  ChooseRouteBottomSheetState createState() => ChooseRouteBottomSheetState();
}

class ChooseRouteBottomSheetState extends ConsumerState<ChooseRouteBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return MapBottomSheet(
      button: MainActionButton(text: context.l10n.start_route, onPressed: () async {}),
      child: Container(
        padding: const EdgeInsets.all(SelectRouteConfig.contentPadding),
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: mockData.length,
          itemBuilder: (context, index) {
            return Text("Route ${index + 1}");
          },
        ),
      ),
    );
  }
}
