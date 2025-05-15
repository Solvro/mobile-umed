abstract class BottomSheetConfig {
  // main paddings
  static const horizontalPadding = 20.0;
  static const smallVerticalPadding = 8.0;

  // fixed button
  static const mainButtonVerticalPadding = 10.0;
  static const fixedBottomSpace = 95.0;

  // sheet content percent
  static const fullSizePercent = 0.5;
  static const halfSizePercent = 0.3;
  static const hiddenSizePercent = 0.04;
}

abstract class BottomSheetHeaderConfig {
  // handle
  static const handleLength = 35.0;
  static const handleWidth = 5.0;
  static const handleContentSpacing = 15.0;

  // controls
  static const headerWithControls = 100.0;
  static const headerWithoutControls = 40.0;
  static const controlsSpacing = 20.0;

  static const roundedTopRadius = 15.0;
}

abstract class PlaylistInfoConfig {
  static const contentPadding = 5.0;
  static const verticalSpacing = 15.0;
  static const horizontalButtonSpacing = 25.0;

  // song tile
  static const songTileDotRad = 20.0;
  static const songTileSpacing = 20.0;
}

abstract class RouteInfoConfig {
  static const contentPadding = 5.0;
  static const verticalSpacing = 15.0;

  static const infoBubbleMinHeight = 40.0;
  static const infoBubbleRoundedRad = 30.0;
  static const infoBubbleSpacing = 15.0;
}

abstract class ProgressBarConfig {
  // general
  static const topPadding = 4.0;
  static const bottomPadding = 10.0;
  static const horizontalPadding = 25.0;
  static const radius = 12.0;

  // progressLine
  static final notDoneAlpha = (0.3 * 255).toInt();
  static const dotRad = 4.0;
  static const dotLinePadding = 2.0;
  static const lineHeight = 2.0;
}

abstract class ButtonsConfig {
  static const secondaryButtonRadius = 20.0;
  static const secondaryButtonShadowRadius = 25.0;

  static const minimumSize = 44.0;
}
