import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../../common/models/route_stats.dart";

part "route_stats_provider.g.dart";

@Riverpod(dependencies: [], keepAlive: true)
class RouteStats extends _$RouteStats {
  @override
  RouteStatsModel build() {
    return const RouteStatsModel(elapsed: Duration.zero, distance: 0);
  }

  void updateStats(RouteStatsModel stats) {
    state = stats;
  }
}
