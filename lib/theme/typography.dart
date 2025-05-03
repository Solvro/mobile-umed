import "package:flutter/material.dart";

import "colors.dart";

class BodyTextStyle extends TextStyle {
  const BodyTextStyle({
    super.fontWeight = FontWeight.w400,
    super.fontSize = 13.0,
    super.color = ColorsConsts.onyx,
    super.height = 1.2,
    super.shadows,
  }) : super(letterSpacing: 0); // TODO(BombardierBulge): Add font family
}

class BoldBodyTextStyle extends BodyTextStyle {
  const BoldBodyTextStyle({super.fontSize, super.color}) : super(fontWeight: FontWeight.w500);
}

class HeadlineTextStyle extends BoldBodyTextStyle {
  const HeadlineTextStyle({super.color}) : super(fontSize: 17);
}

class TitleTextStyle extends BoldBodyTextStyle {
  const TitleTextStyle({super.color}) : super(fontSize: 15);
}
