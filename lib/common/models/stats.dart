import "package:freezed_annotation/freezed_annotation.dart";

part "stats.freezed.dart";
part "stats.g.dart";

@freezed
abstract class Stats with _$Stats {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Stats(
      {required int id,
      required String value,
      required int iconCode,
      required int iconColor}) = _Stats;

  factory Stats.fromJson(Map<String, dynamic> json) => _$StatsFromJson(json);
}
