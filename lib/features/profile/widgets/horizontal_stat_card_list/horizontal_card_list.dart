import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../common/models/stats.dart";
import "card.dart";

class StatListWidget extends StatelessWidget {
  final IList<Stats> stats;
  final double height;
  final double itemWidth;
  final double sideMargin;
  final double iconSize;

  const StatListWidget({
    required this.stats,
    this.height = CardListConfig.height,
    this.itemWidth = CardListConfig.itemWidth,
    this.sideMargin = AppPaddings.medium,
    this.iconSize = CardListConfig.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, __) =>
            const SizedBox(width: AppPaddings.tinySmall),
        itemBuilder: (_, index) {
          final stat = stats[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppPaddings.nano),
            child: StatCard(
                stat: stat,
                iconSize: iconSize,
                width: itemWidth,
                height: height),
          );
        },
      ),
    );
  }
}
