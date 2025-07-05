import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

import "../../../../app/config/ui_config.dart";

class RouteListShimmer extends StatelessWidget {
  const RouteListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: HomeViewConfig.sideMargin),
      child: SizedBox(
        height: RouteListConfig.height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: AppPaddings.tinySmall),
            itemBuilder:
                (_, __) => Container(
                  width: RouteListConfig.itemWidth,
                  height: RouteListConfig.height,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                ),
          ),
        ),
      ),
    );
  }
}
