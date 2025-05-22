import "package:flutter/material.dart";
import "../../../../../app/config/ui_config.dart";
import "../../../../../common/models/landmark.dart";
import "../../../../../common/widgets/cached_image.dart";
import "../../../../../common/widgets/info_modal.dart";

class LandmarkInfoModal extends StatelessWidget {
  final Landmark landmark;

  const LandmarkInfoModal({super.key, required this.landmark});

  @override
  Widget build(BuildContext context) {
    return InfoModal(
      title: landmark.name,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(LandmarkInfoModalConfig.imageRadius),
            child: const CachedImage(
              //for now there is no image url property in the landmark model
              "https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg",
            ),
          ),

          const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),

          Flexible(
            child: Text(landmark.description, maxLines: 7, textAlign: TextAlign.start, overflow: TextOverflow.fade),
          ),
          const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),
        ],
      ),
    );
  }
}
