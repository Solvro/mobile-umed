import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/data_source/local/achievments_repository.dart";
import "../../../common/models/achievement.dart";

part "achievments_controller.g.dart";

@riverpod
Future<IList<Achievement>> achievementController(Ref ref) async {
  final allAchievements = ref.watch(achievementRepositoryProvider);

  final results = await Future.wait(allAchievements.map((a) async => (a, await a.isAchieved(ref))));

  return results.where((entry) => entry.$2).map((entry) => entry.$1).toIList();
}
