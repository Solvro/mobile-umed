import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";
import "../../../../app/config/ui_config.dart";

class CreatorTileShimmerList extends StatelessWidget {
  final int count;
  const CreatorTileShimmerList({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: InfoSectionConfig.creatorTileHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        separatorBuilder: (context, index) => const SizedBox(width: AppPaddings.nano),
        itemBuilder: (context, index) => const CreatorTileShimmer(),
      ),
    );
  }
}

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
          baseColor: ShimmerConfig.baseColor,
          highlightColor: ShimmerConfig.highlightColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: InfoSectionConfig.creatorShimmerPhotoHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(InfoSectionConfig.radius)),
                ),
              ),
              const SizedBox(height: AppPaddings.medium),
              Container(
                height: InfoSectionConfig.creatorShimmerNameHeight,
                width: InfoSectionConfig.creatorShimmerNameWidth,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.nano)),
              ),
              const SizedBox(height: AppPaddings.nanoTiny),
              Container(
                height: InfoSectionConfig.creatorShimmerRoleHeight,
                width: InfoSectionConfig.creatorShimmerRoleWidth,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.nano)),
              ),
              const SizedBox(height: AppPaddings.small),
              Container(
                height: InfoSectionConfig.creatorShimmerSocialsHeight,
                width: InfoSectionConfig.creatorShimmerSocialsWidth,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(AppRadius.tiny)),
              ),
              const SizedBox(height: AppPaddings.tiny),
            ],
          ),
        ),
      ),
    );
  }
}
