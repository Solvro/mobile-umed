import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";
import "../../../../app/config/ui_config.dart";

class CreatorTileShimmer extends StatelessWidget {
  const CreatorTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(InfoSectionConfig.radius)),
      elevation: 4,
      child: SizedBox(
        height: InfoSectionConfig.creatorTileHeight,
        width: InfoSectionConfig.creatorTileWidth,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(InfoSectionConfig.radius)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 18,
                width: 100,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 6),
              Container(
                height: 14,
                width: 60,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(height: 16),
              Container(
                height: 24,
                width: 80,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
              ),
              const SizedBox(height: AppPaddings.tiny),
            ],
          ),
        ),
      ),
    );
  }
}
