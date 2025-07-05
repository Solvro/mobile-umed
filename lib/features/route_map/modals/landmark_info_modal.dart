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
    final infoWidgets = [
      LabelValuePair(label: context.l10n.name, value: landmark.name),
      LabelValuePair(label: context.l10n.type, value: landmark.type.toText(context)),
      if (landmark.dateOfCreation != null)
        LabelValuePair(label: context.l10n.date_of_creation, value: landmark.dateOfCreation.toString()),
      if (landmark.designer != null) LabelValuePair(label: context.l10n.designer, value: landmark.designer!),
    ];

    final List<Widget> infoRows = [];
    for (var i = 0; i < infoWidgets.length; i += 2) {
      infoRows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppPaddings.small,
          children: [
            Expanded(child: infoWidgets[i]),
            if (i + 1 < infoWidgets.length) Expanded(child: infoWidgets[i + 1]) else const Expanded(child: SizedBox()),
          ],
        ),
      );
    }

    return InfoModal(
      title: context.l10n.checkpoint,
      child: SingleChildScrollView(
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
              children: [...infoRows, LabelValuePair(label: context.l10n.description, value: landmark.description)],
            ),

            const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),
          ],
        ),
      ),
    );
  }
}
