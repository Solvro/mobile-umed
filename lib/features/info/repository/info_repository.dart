import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../common/data_source/remote/dio_client.dart";
import "../../../common/models/creator.dart";
import "../../../common/models/info_section.dart";
import "info_repository_helpers.dart";

part "info_repository.g.dart";

@riverpod
Future<Creator> fetchCreatorWithId(Ref ref, int id) async {
  final dio = await ref.read(dioClientProvider.future);
  return fetchSingleWithSocials<Creator>(
    dio: dio,
    dataEndpoint: "items/creators/$id",
    fromJson: Creator.fromJson,
    getSocialId: (creator) => creator.socialUrls,
    copyWithSocials: (creator, socials) => creator.copyWith(socials: socials),
  );
}

@riverpod
Future<InfoSection> fetchInfoWithId(Ref ref, int id) async {
  final dio = await ref.read(dioClientProvider.future);
  return fetchSingleWithSocials<InfoSection>(
    dio: dio,
    dataEndpoint: "items/info_section/$id",
    fromJson: InfoSection.fromJson,
    getSocialId: (infoSection) => infoSection.socialUrls,
    copyWithSocials: (infoSection, socials) => infoSection.copyWith(socials: socials),
  );
}

@riverpod
Future<({IList<Creator> creators, IList<InfoSection> infoSections})> fetchCreatorsAndInfos(Ref ref) async {
  final dio = await ref.read(dioClientProvider.future);

  final results = await Future.wait([
    fetchAllWithSocials<Creator>(
      dio: dio,
      dataEndpoint: "items/creators",
      fromJson: Creator.fromJson,
      getSocialId: (creator) => creator.socialUrls,
      copyWithSocials: (creator, socials) => creator.copyWith(socials: socials),
    ),
    fetchAllWithSocials<InfoSection>(
      dio: dio,
      dataEndpoint: "items/info_section",
      fromJson: InfoSection.fromJson,
      getSocialId: (infoSection) => infoSection.socialUrls,
      copyWithSocials: (infoSection, socials) => infoSection.copyWith(socials: socials),
    ),
  ]);

  await Future.delayed(const Duration(milliseconds: 5000)); // Simulate network delay

  return (creators: results[0] as IList<Creator>, infoSections: results[1] as IList<InfoSection>);
}
