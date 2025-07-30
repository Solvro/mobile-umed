import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "../../../common/models/socials.dart";

typedef FromJson<T> = T Function(Map<String, dynamic>);
typedef GetSocialId<T> = int? Function(T instance);
typedef WithSocials<T> = T Function(T original, Socials? socials);

Future<IList<T>> fetchAllWithSocials<T>({
  required Dio dio,
  required String dataEndpoint,
  required FromJson<T> fromJson,
  required GetSocialId<T> getSocialId,
  required WithSocials<T> copyWithSocials,
}) async {
  final dataResponse = await dio.get<Map<String, dynamic>>(dataEndpoint);
  final socialsResponse =
      await dio.get<Map<String, dynamic>>("items/social_urls/");

  final dataList = dataResponse.data!["data"] as List<dynamic>;
  final socialsData = socialsResponse.data!["data"] as List<dynamic>;

  final socialsList = socialsData
      .map((e) => Socials.fromJson(e as Map<String, dynamic>))
      .toList()
      .lock;
  final socialsMap = {
    for (final socialsItem in socialsList) socialsItem.id: socialsItem
  };

  return dataList
      .map((e) {
        final item = fromJson(e as Map<String, dynamic>);
        final socialId = getSocialId(item);
        final social = (socialId != null) ? socialsMap[socialId] : null;
        return copyWithSocials(item, social);
      })
      .toList()
      .lock;
}

Future<T> fetchSingleWithSocials<T>({
  required Dio dio,
  required String dataEndpoint,
  required FromJson<T> fromJson,
  required GetSocialId<T> getSocialId,
  required WithSocials<T> copyWithSocials,
}) async {
  final itemResponse = await dio.get<Map<String, dynamic>>(dataEndpoint);
  final itemData = itemResponse.data!["data"] as List<dynamic>;
  if (itemData.isEmpty) {
    throw Exception("No data found at $dataEndpoint");
  }
  final item = fromJson(itemData[0] as Map<String, dynamic>);
  final socialsId = getSocialId(item);
  Socials? socials;
  if (socialsId != null) {
    final socialsResp =
        await dio.get<Map<String, dynamic>>("items/social_urls/$socialsId");
    final socialsData = socialsResp.data!["data"] as Map<String, dynamic>;
    socials = Socials.fromJson(socialsData);
  }

  return copyWithSocials(item, socials);
}
