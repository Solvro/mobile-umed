import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../common/widgets/shimmer/box_shimmer.dart";
import "../widgets/creator_tile/creator_tile_shimmer_list.dart";

class InfoLoadingView extends StatelessWidget {
  const InfoLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(AppPaddings.small),
        children: const [
          SizedBox(height: AppPaddings.big),
          BoxShimmer(),
          SizedBox(height: AppPaddings.big),
          BoxShimmer(),
          SizedBox(height: AppPaddings.big),
          CreatorTileShimmerList(),
        ],
      ),
    );
  }
}
