import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/data_source/remote/dio_client.dart";
import "../../../common/models/creator.dart";
import "../../../common/models/info_section.dart";
import "info_repository_helpers.dart";

part "info_repository.g.dart";

@riverpod
Future<({IList<Creator> creators, IList<InfoSection> infoSections})> fetchCreatorsAndInfos(Ref ref) async {
  final dio = await ref.watch(dioClientProvider.future);

  final results = await Future.wait([fetchAllCreators(dio), fetchAllInfoSections(dio)]);

  return (creators: results[0] as IList<Creator>, infoSections: results[1] as IList<InfoSection>);
}
