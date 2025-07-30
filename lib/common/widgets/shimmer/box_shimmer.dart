import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

import "../../../app/config/ui_config.dart";

class BoxShimmer extends StatelessWidget {
  const BoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: Container(
        height: RouteListConfig.height,
        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(AppRadius.small)),
      ),
    );
  }
}
