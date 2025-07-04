import "package:flutter/material.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../common/models/landmark.dart";
import "../../../common/widgets/cached_image.dart";
import "../../../common/widgets/common/label_value_pair.dart";
import "../../../common/widgets/info_modal.dart";

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
          const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),

          ClipRRect(
            borderRadius: BorderRadius.circular(LandmarkInfoModalConfig.imageRadius),
            child: const CachedImage(
              //for now there is no image url property in the landmark model
              "https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg",
            ),
          ),

          const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),

          Column(
            spacing: AppPaddings.tiny,
            children: [
              Row(
                spacing: AppPaddings.tiny,
                children: [
                  Expanded(child: LabelValuePair(label: context.l10n.name, value: landmark.name)),
                  Expanded(
                    child: LabelValuePair(
                      label: context.l10n.date_of_creation,
                      value: landmark.dateOfCreation.toString(),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: AppPaddings.tiny,
                children: [
                  Expanded(
                    child: LabelValuePair(
                      label: context.l10n.type,
                      value:
                          landmark.type == LandmarkType.checkpoint
                              ? context.l10n.checkpoint_type
                              : context.l10n.pulsometer_type,
                    ),
                  ),
                  Expanded(
                    child: LabelValuePair(
                      label: context.l10n.designer,
                      value: landmark.designer ?? context.l10n.unknown_designer,
                    ),
                  ),
                ],
              ),
              LabelValuePair(label: context.l10n.description, value: landmark.description),
            ],
          ),

          const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),
        ],
      ),
    );
  }
}
