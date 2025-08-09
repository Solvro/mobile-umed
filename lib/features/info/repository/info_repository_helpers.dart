import "package:dio/dio.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "../../../common/models/creator.dart";
import "../../../common/models/info_section.dart";

Future<IList<Creator>> fetchAllCreators(Dio dio) async {
  final response = await dio.get<Map<String, dynamic>>("items/creators?fields=*,social_urls.*");
  final data = response.data?["data"] as List<dynamic>?;
  return data?.map((e) => Creator.fromJson(e as Map<String, dynamic>)).toList().lock ?? IList<Creator>();
}

Future<IList<InfoSection>> fetchAllInfoSections(Dio dio) async {
  final response = await dio.get<Map<String, dynamic>>("items/info_section?fields=*,social_urls.*");
  final data = response.data?["data"] as List<dynamic>?;
  return data?.map((e) => InfoSection.fromJson(e as Map<String, dynamic>)).toList().lock ?? IList<InfoSection>();
}
