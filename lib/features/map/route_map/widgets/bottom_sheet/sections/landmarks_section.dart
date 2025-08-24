import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../../../app/config/ui_config.dart";
import "../../../../../../common/models/checkpoint.dart";
import "../tiles/landmark_item.dart";

class LandmarksSection extends StatelessWidget {
  const LandmarksSection({super.key, required this.checkpoints});

  final IList<Checkpoint> checkpoints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CheckpointsSectionConfig.contentPadding),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: checkpoints.length,
        itemBuilder: (context, index) {
          return LandmarkItem(listIndex: index, checkpoint: checkpoints[index]);
        },
      ),
    );
  }
}
