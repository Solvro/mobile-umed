import "package:flutter/material.dart";
import "../../../common/models/landmark.dart";
import "../../../common/widgets/cached_image.dart";
import "../../../common/widgets/main_action_button.dart";

class LandmarkInfoModal extends StatelessWidget {
  final Landmark landmark;

  const LandmarkInfoModal({super.key, required this.landmark});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fit to content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(landmark.name),

            const SizedBox(height: 12),

            // Image placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const CachedImage(
                //for now there is no image url property in the landmark model
                "https://images.squarespace-cdn.com/content/v1/60f1a490a90ed8713c41c36c/1629223610791-LCBJG5451DRKX4WOB4SP/37-design-powers-url-structure.jpeg",
              ),
            ),

            const SizedBox(height: 20),

            // Description field
            Expanded(
              child: Text(landmark.description, maxLines: 15, textAlign: TextAlign.start, overflow: TextOverflow.fade),
            ),
            MainActionButton(text: "Zamknij", onPressed: () => Navigator.of(context).pop()),
          ],
        ),
      ),
    );
  }
}
