// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppThemeTailorMixin on ThemeExtension<AppTheme> {
  AppColorTheme get colorTheme;
  AppTextTheme get textTheme;

  @override
  AppTheme copyWith({AppColorTheme? colorTheme, AppTextTheme? textTheme}) {
    return AppTheme(colorTheme: colorTheme ?? this.colorTheme, textTheme: textTheme ?? this.textTheme);
  }

  @override
  AppTheme lerp(covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this as AppTheme;
    return AppTheme(
      colorTheme: colorTheme.lerp(other.colorTheme, t),
      textTheme: textTheme.lerp(other.textTheme, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppTheme &&
            const DeepCollectionEquality().equals(colorTheme, other.colorTheme) &&
            const DeepCollectionEquality().equals(textTheme, other.textTheme));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(colorTheme),
      const DeepCollectionEquality().hash(textTheme),
    );
  }
}

extension AppThemeBuildContextProps on BuildContext {
  AppTheme get appTheme => Theme.of(this).extension<AppTheme>()!;
  AppColorTheme get colorTheme => appTheme.colorTheme;
  AppTextTheme get textTheme => appTheme.textTheme;
}
