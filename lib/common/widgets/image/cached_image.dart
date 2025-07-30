import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "../../../app/config/cached_image_config.dart";
import "no_image_placeholder.dart";

class CachedImage extends StatelessWidget {
  const CachedImage(
    this.imageUrl, {
    super.key,
    this.loadingType = LoadingType.circularProgressIndicator,
    this.boxFit = BoxFit.cover,
    this.size,
  });

  final String? imageUrl;
  final LoadingType loadingType;
  final BoxFit boxFit;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return NoImagePlaceholder(size: size);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: boxFit,
      cacheManager: CachedImageConfig.cacheManagerInstance,
      placeholder: switch (loadingType) {
        LoadingType.noLoading => null,
        LoadingType.circularProgressIndicator => (context, url) =>
            const Center(child: CircularProgressIndicator()),
      },
      errorWidget: (context, url, error) => NoImagePlaceholder(size: size),
      height: size?.height,
      width: size?.width,
    );
  }
}

enum LoadingType { noLoading, circularProgressIndicator }
