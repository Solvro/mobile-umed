import "package:flutter/material.dart";
import "package:theme_tailor_annotation/theme_tailor_annotation.dart";

import "colors.dart";
import "typography.dart";

part "app_text_theme.tailor.dart";

@tailorMixinComponent
class AppTextTheme extends ThemeExtension<AppTextTheme> with _$AppTextThemeTailorMixin {
  const AppTextTheme({
    // Headline 17px, w500
    this.headline = const HeadlineTextStyle(),
    // Title 15px, w500
    this.title = const TitleTextStyle(),
    this.titleWhite = const TitleTextStyle(color: ColorsConsts.white),

    // Body 13px, w400
    this.body = const BodyTextStyle(),
    this.bodyGrey = const BodyTextStyle(color: ColorsConsts.dimGray),

    this.boldBody = const BoldBodyTextStyle(),
    this.boldBodyGrey = const BoldBodyTextStyle(color: ColorsConsts.dimGray),
  });

  @override
  final TextStyle headline;
  @override
  final TextStyle title;
  @override
  final TextStyle titleWhite;
  @override
  final TextStyle body;
  @override
  final TextStyle bodyGrey;
  @override
  final TextStyle boldBody;
  @override
  final TextStyle boldBodyGrey;
}
