import "package:freezed_annotation/freezed_annotation.dart";

import "socials.dart";

part "info_section.freezed.dart";
part "info_section.g.dart";

@freezed
abstract class InfoSection with _$InfoSection {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory InfoSection({
    required int id,
    required String description,
    required String title,
    String? subtitle,
    Socials? socialUrls,
  }) = _InfoSection;

  factory InfoSection.fromJson(Map<String, dynamic> json) => _$InfoSectionFromJson(json);
}
