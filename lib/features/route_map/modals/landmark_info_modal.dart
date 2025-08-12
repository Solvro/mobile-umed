import "package:flutter/material.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../common/models/checkpoint.dart";
import "../../../common/widgets/image/cached_image.dart";
import "../../../common/widgets/modals/info_modal.dart";
import "../../../common/widgets/styling/label_value_pair.dart";

class LandmarkInfoModal extends StatelessWidget {
  final Checkpoint checkpoint;

  const LandmarkInfoModal({super.key, required this.checkpoint});

  @override
  Widget build(BuildContext context) {
    final infoWidgets = [
      LabelValuePair(label: context.l10n.landmark_name, value: checkpoint.name),
      LabelValuePair(label: context.l10n.landmark_type, value: checkpoint.type.toText(context.l10n)),
      if (checkpoint.dateOfCreation != null)
        LabelValuePair(label: context.l10n.landmark_date_of_creation, value: checkpoint.dateOfCreation.toString()),
      if (checkpoint.designer != null)
        LabelValuePair(label: context.l10n.landmark_designer, value: checkpoint.designer!),
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
      title: context.l10n.landmark_checkpoint,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),
            ClipRRect(
              borderRadius: BorderRadius.circular(LandmarkInfoModalConfig.imageRadius),
              child: const CachedImage(""), // TODO(tt): Replace with actual image URL
            ),
            const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),
            Column(
              spacing: AppPaddings.tiny,
              children: [
                ...infoRows,
                LabelValuePair(
                  label: context.l10n.description,
                  value: checkpoint.description ?? context.l10n.landmark_no_description,
                ),
              ],
            ),
            const SizedBox(height: LandmarkInfoModalConfig.verticalSpacing),
          ],
        ),
      ),
    );
  }
}
