import "package:freezed_annotation/freezed_annotation.dart";

import "socials.dart";

part "creator.freezed.dart";
part "creator.g.dart";

@freezed
abstract class Creator with _$Creator {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Creator({
    required int id,
    required String firstName,
    required String lastName,
    required String role,
    String? imageUrl,
    Socials? socialUrls,
  }) = _Creator;

  factory Creator.fromJson(Map<String, dynamic> json) => _$CreatorFromJson(json);
}
