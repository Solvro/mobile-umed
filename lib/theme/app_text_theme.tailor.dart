// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_text_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppTextThemeTailorMixin on ThemeExtension<AppTextTheme> {
  TextStyle get headline;
  TextStyle get title;
  TextStyle get titleWhite;
  TextStyle get body;
  TextStyle get bodyGrey;
  TextStyle get boldBody;
  TextStyle get boldBodyGrey;

  @override
  AppTextTheme copyWith({
    TextStyle? headline,
    TextStyle? title,
    TextStyle? titleWhite,
    TextStyle? body,
    TextStyle? bodyGrey,
    TextStyle? boldBody,
    TextStyle? boldBodyGrey,
  }) {
    return AppTextTheme(
      headline: headline ?? this.headline,
      title: title ?? this.title,
      titleWhite: titleWhite ?? this.titleWhite,
      body: body ?? this.body,
      bodyGrey: bodyGrey ?? this.bodyGrey,
      boldBody: boldBody ?? this.boldBody,
      boldBodyGrey: boldBodyGrey ?? this.boldBodyGrey,
    );
  }

  @override
  AppTextTheme lerp(covariant ThemeExtension<AppTextTheme>? other, double t) {
    if (other is! AppTextTheme) return this as AppTextTheme;
    return AppTextTheme(
      headline: TextStyle.lerp(headline, other.headline, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      titleWhite: TextStyle.lerp(titleWhite, other.titleWhite, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      bodyGrey: TextStyle.lerp(bodyGrey, other.bodyGrey, t)!,
      boldBody: TextStyle.lerp(boldBody, other.boldBody, t)!,
      boldBodyGrey: TextStyle.lerp(boldBodyGrey, other.boldBodyGrey, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppTextTheme &&
            const DeepCollectionEquality().equals(headline, other.headline) &&
            const DeepCollectionEquality().equals(title, other.title) &&
            const DeepCollectionEquality().equals(titleWhite, other.titleWhite) &&
            const DeepCollectionEquality().equals(body, other.body) &&
            const DeepCollectionEquality().equals(bodyGrey, other.bodyGrey) &&
            const DeepCollectionEquality().equals(boldBody, other.boldBody) &&
            const DeepCollectionEquality().equals(boldBodyGrey, other.boldBodyGrey));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(headline),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(titleWhite),
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(bodyGrey),
      const DeepCollectionEquality().hash(boldBody),
      const DeepCollectionEquality().hash(boldBodyGrey),
    );
  }
}
