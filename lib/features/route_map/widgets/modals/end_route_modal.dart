import "package:flutter/material.dart";

import "../../../../app/theme/app_theme.dart";
import "../../../../common/widgets/cached_image.dart";
import "../../../../common/widgets/main_action_button.dart";
import "../../../../common/widgets/options_modal.dart";

class EndRouteModal extends StatelessWidget {
  const EndRouteModal({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionsModal(
      title: "Czy na pewno chcesz zakończyć trasę?",
      confirmButton: MainActionButton(
        backgroundColor: context.colorScheme.secondary,
        text: "Zakończ trasę",
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
      cancelButton: MainActionButton(text: "Kontynuuj trasę!", onPressed: () => Navigator.of(context).pop()),
      child: Column(
        children: [
          const Text(
            "Lorem ipusf dsahaasfd gh iuiuh  dsuhifwefiweeaw",
            textAlign: TextAlign.start,
            overflow: TextOverflow.fade,
          ),

          const SizedBox(height: 10),
          // Image placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: const CachedImage(
              //for now there is no image url property in the landmark model
              "https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg",
            ),
          ),
        ],
      ),
    );
  }
}
