import "package:flutter/material.dart";
import "../../../common/models/landmark.dart";
import "../../../common/widgets/cached_image.dart";

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(landmark.name),
                IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => Navigator.of(context).pop()),
              ],
            ),
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
            SizedBox(height: 400, child: Text(landmark.description, maxLines: 15)),
          ],
        ),
      ),
    );
  }
}
