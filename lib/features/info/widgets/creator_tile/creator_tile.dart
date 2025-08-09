import "package:flutter/material.dart";
import "../../../../app/config/cached_image_config.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../app/theme/app_theme.dart";
import "../../../../common/models/creator.dart";
import "../../../../common/widgets/image/cached_image.dart";
import "../socials_section.dart";

class CreatorTile extends StatelessWidget {
  const CreatorTile(this.creator, {super.key});
  final Creator creator;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(InfoSectionConfig.radius)),
      elevation: 4,
      child: SizedBox(
        height: InfoSectionConfig.creatorTileHeight,
        width: InfoSectionConfig.creatorTileWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedImage(CachedImageConfig.getDirectusUrl(creator.imageUrl)),
            Text("${creator.firstName} ${creator.lastName}", style: context.textTheme.bodyMedium),
            Text(creator.role, style: context.textTheme.bodySmall),
            if (creator.socialUrls != null) SocialsSection(socials: creator.socialUrls!),
            const SizedBox(height: AppPaddings.tiny),
          ],
        ),
      ),
    );
  }
}
