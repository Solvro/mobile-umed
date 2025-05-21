import "package:flutter/material.dart";

abstract class AppPaddings {
  static const medium = 20.0;
  static const small = 16.0;
  static const tinySmall = 10.0;
  static const tiny = 8.0;
}

abstract class BottomSheetConfig {
  // fixed button
  static const fixedBottomSpace = 95.0;

  // sheet content percent
  static const fullSizePercent = 0.45;
  static const halfSizePercent = 0.25;
  static const hiddenSizePercent = 0.04;
  static const tolerance = 0.01;
}

abstract class BottomSheetHeaderConfig {
  // handle
  static const handleIconSize = 30.0;

  // controls
  static const headerWithControls = 100.0;
  static const headerWithoutControls = 40.0;
  static const controlsSpacing = 20.0;

  static const roundedTopRadius = 15.0;
}

abstract final class PlaylistInfoConfig {
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
  static const horizontalPadding = 25.0;
  static const radius = 12.0;

  // progressLine
  static final notDoneAlpha = (0.3 * 255).toInt();
  static const dotLinePadding = 2.0;
  static const lineHeight = 2.0;
}

abstract class ButtonsConfig {
  static const secondaryButtonRadius = 20.0;
  static const secondaryButtonShadowRadius = 25.0;
  static const secondaryButtonPadding = 6.0;
}

abstract class InfoModalConfig {
  static const radius = 15.0;
  static const outerPaddingVertical = 105.0;
  static const decorationOpacity = 0.5;
}

abstract class OptionsModalConfig {
  static const radius = 15.0;
  static const outerPaddingVertical = 195.0;
  static const titleSpacer = 6.0;
}

abstract class LandmarkInfoModalConfig {
  static const verticalSpacing = 20.0;
  static const imageRadius = 12.0;
}

abstract class EndRouteModalConfig {
  static const imageRadius = 12.0;
}

abstract class RouteCompleteModalConfig {
  static const distanceInfoColor = Colors.brown;
  static const timeInfoColor = Colors.blueGrey;
  static const caloriesInfoColor = Colors.red;
  static const paceInfoColor = Colors.deepPurple;
  static const verticalSpacing = 16.0;
  static const horizontalSpacing = 26.0;
  static const decorationSize = 120.0;
}

abstract final class MapConfig {
  // marker
  static const markerSize = 80.0;
  static const textSize = 30.0;
  static const markerPadding = 8.0;
  static const markerTextColor = Colors.black;

  // line
  static const visitedLineWidth = 6.0;
  static const unvisitedLineWidth = 5.0;
  static const dashLen = 9.0;
  static const spaceLen = 8.0;
  static const unvisitedColor = Colors.grey;
  static const inactiveColor = Colors.grey;
}

abstract final class StatInfoCompactConfig {
  static const circleSize = 44.0;
  static const boxRad = 32.0;
  static const boxPadding = 2.0;
  static const boxLeftOffset = 10.0;
  static const borderWidth = 2.0;
  static const iconPadding = 6.0;
}
