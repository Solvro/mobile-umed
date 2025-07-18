import "package:flutter/widgets.dart";

import "../../../../../app/config/ui_config.dart";
import "../../../../../app/theme/app_theme.dart";
import "../../../../../common/models/checkpoint.dart";
import "../../../../../common/widgets/list_label.dart";

class LandmarkItem extends StatelessWidget {
  const LandmarkItem({super.key, required this.listIndex, required this.checkpoint});

  final int listIndex;
  final Checkpoint checkpoint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: CheckpointsSectionConfig.landmarkItemSpacing,
      children: [
        ListLabel(index: listIndex),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(checkpoint.name, style: context.textTheme.headlineSmall),
              if (checkpoint.description != null) Text(checkpoint.description!),
            ],
          ),
        ),
      ],
    );
  }
}
