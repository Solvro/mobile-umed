import "package:flutter/material.dart";
import "package:theme_tailor_annotation/theme_tailor_annotation.dart";

import "colors.dart";
import "hex_color.dart";

part "app_color_theme.tailor.dart";

@tailorMixinComponent
class AppColorTheme extends ThemeExtension<AppColorTheme> with _$AppColorThemeTailorMixin {
  const AppColorTheme({
    this.onyx = ColorsConsts.onyx,
    this.white = ColorsConsts.white,
    this.jasper = ColorsConsts.jasper,
    this.green = ColorsConsts.green,
  });
  @override
  final HexColor onyx;
  @override
  final HexColor white;
  @override
  final HexColor jasper;
  @override
  final HexColor green;
}
