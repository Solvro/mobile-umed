import "package:freezed_annotation/freezed_annotation.dart";

part "creator.freezed.dart";
part "creator.g.dart";

@freezed
abstract class Creator with _$Creator {
  const factory Creator({
    required int id,
    required int sort,
    required String firstName,
    required String lastName,
    required String role,
    String? imageUrl,
    int? socialsId,
  }) = _Creator;

  factory Creator.fromJson(Map<String, dynamic> json) => _$CreatorFromJson(json);
}
