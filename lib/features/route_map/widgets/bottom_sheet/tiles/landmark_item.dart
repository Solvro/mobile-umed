import "package:flutter/widgets.dart";

import "../../../../../app/config/ui_config.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../common/models/landmark.dart";
import "../../../../../common/widgets/list_label.dart";

class LandmarkItem extends StatelessWidget {
  const LandmarkItem({super.key, required this.listIndex, required this.landmark});

  final int listIndex;
  final Landmark landmark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: LandmarksSectionConfig.landmarkItemSpacing,
      children: [
        ListLabel(index: listIndex),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [Text(landmark.name, style: context.textTheme.headlineSmall), Text(landmark.description)],
          ),
        ),
      ],
    );
  }
}
