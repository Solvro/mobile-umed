import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/widgets.dart";

import "../../../../../app/config/ui_config.dart";
import "../../../../../common/models/landmark.dart";
import "../tiles/landmark_item.dart";

class LandmarksSection extends StatelessWidget {
  const LandmarksSection({super.key, required this.landmarks});

  final IList<Landmark> landmarks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(LandmarksSectionConfig.contentPadding),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: landmarks.length,
        itemBuilder: (context, index) {
          return LandmarkItem(listIndex: index, landmark: landmarks[index]);
        },
      ),
    );
  }
}
