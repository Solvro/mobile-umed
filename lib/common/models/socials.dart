import "package:freezed_annotation/freezed_annotation.dart";

part "socials.freezed.dart";
part "socials.g.dart";

@freezed
abstract class Socials with _$Socials {
  const factory Socials({
    required int id,
    String? webUrl,
    String? githubUrl,
    String? facebookUrl,
    String? linkedinUrl,
    String? email,
  }) = _Socials;

  factory Socials.fromJson(Map<String, dynamic> json) => _$SocialsFromJson(json);
}
