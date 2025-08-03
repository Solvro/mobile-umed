import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../common/data_source/mocks/mock_routes.dart";
import "../../../common/models/creator.dart";
import "../../../common/widgets/horizontal_routes_list/horizontal_routes_list.dart";
import "../../../common/widgets/shimmer/horizontal_list_shimmer.dart";
import "../../../common/widgets/shimmer/shimmer_switcher.dart";
import "../../info/widgets/creator_tile/creator_tile.dart";
import "../../info/widgets/creator_tile/creator_tile_shimmer_list.dart";

class ShimmerTestWidget extends StatefulWidget {
  const ShimmerTestWidget({super.key});

  @override
  State<ShimmerTestWidget> createState() => _ShimmerTestWidgetState();
}

class _ShimmerTestWidgetState extends State<ShimmerTestWidget> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    final mockRoutes = mockData;

    return Column(
      children: [
        const SizedBox(height: 4),
        SwitchListTile(
          title: const Text("Przełącz ładowanie"),
          value: isLoading,
          onChanged: (val) => setState(() => isLoading = val),
        ),
        const SizedBox(height: 16),
        const Text("Shimmer dla listy tras"),
        ShimmerSwitcher(
          isLoading: isLoading,
          shimmer: const RouteListShimmer(key: ShimmerConfig.shimmerKey),
          child: RouteListWidget(
            key: ShimmerConfig.listKey,
            routes: mockRoutes.lock,
            onRouteTap: (_) {},
            icon: Icons.arrow_forward_ios,
          ),
        ),
        const SizedBox(height: 32),
        const Text("Shimmer twórcy"),
        ShimmerSwitcher(
          isLoading: isLoading,
          shimmer: const CreatorTileShimmerList(key: ShimmerConfig.shimmerKey),
          child: SizedBox(
            height: InfoSectionConfig.creatorTileHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(width: AppPaddings.nano),
              itemBuilder:
                  (context, index) => CreatorTile(
                    Creator(id: index + 1, firstName: "Jan", lastName: "Kowalski", imageUrl: "", role: "Developer"),
                    key: ValueKey("creator_$index"),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
