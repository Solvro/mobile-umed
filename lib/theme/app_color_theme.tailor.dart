// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_color_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppColorThemeTailorMixin on ThemeExtension<AppColorTheme> {
  HexColor get onyx;
  HexColor get white;
  HexColor get jasper;
  HexColor get green;

  @override
  AppColorTheme copyWith({
    HexColor? onyx,
    HexColor? white,
    HexColor? jasper,
    HexColor? green,
  }) {
    return AppColorTheme(
      onyx: onyx ?? this.onyx,
      white: white ?? this.white,
      jasper: jasper ?? this.jasper,
      green: green ?? this.green,
    );
  }

  @override
  AppColorTheme lerp(covariant ThemeExtension<AppColorTheme>? other, double t) {
    if (other is! AppColorTheme) return this as AppColorTheme;
    return AppColorTheme(
      onyx: t < 0.5 ? onyx : other.onyx,
      white: t < 0.5 ? white : other.white,
      jasper: t < 0.5 ? jasper : other.jasper,
      green: t < 0.5 ? green : other.green,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppColorTheme &&
            const DeepCollectionEquality().equals(onyx, other.onyx) &&
            const DeepCollectionEquality().equals(white, other.white) &&
            const DeepCollectionEquality().equals(jasper, other.jasper) &&
            const DeepCollectionEquality().equals(green, other.green));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(onyx),
      const DeepCollectionEquality().hash(white),
      const DeepCollectionEquality().hash(jasper),
      const DeepCollectionEquality().hash(green),
    );
  }
}
