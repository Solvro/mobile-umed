import "package:flutter/material.dart";
import "../../../common/models/landmark.dart";

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
              child: Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Icon(Icons.image, size: 48, color: Colors.grey),
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
