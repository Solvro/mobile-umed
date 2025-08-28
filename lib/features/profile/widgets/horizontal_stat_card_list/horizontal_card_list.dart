import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../../common/models/achievement.dart";
import "../../../../common/models/stat.dart";
import "card.dart";

class StatListWidget<T extends Stat> extends StatelessWidget {
  final IList<T> stats;
  final double height;
  final double itemWidth;
  final double sideMargin;
  final double iconSize;
  final void Function(T stat)? onTap;

  const StatListWidget({
    required this.stats,
    this.height = CardListConfig.height,
    this.itemWidth = CardListConfig.itemWidth,
    this.sideMargin = AppPaddings.medium,
    this.iconSize = CardListConfig.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppPaddings.tinySmall),
        itemBuilder: (_, index) {
          final stat = stats[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppPaddings.nano),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadius.small),
              onTap: onTap != null ? () => onTap!(stat) : null,
              child: StatCard(
                stat: stat,
                iconSize: iconSize,
                width: itemWidth,
                height: height,
                isValueText: T == Achievement,
              ),
            ),
          );
        },
      ),
    );
  }
}
