import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

abstract class AppPaddings {
  static const veryLarge = 140.0;
  static const large = 50.0;
  static const big = 30.0;
  static const medium = 20.0;
  static const small = 16.0;
  static const tinySmall = 10.0;
  static const tiny = 8.0;
  static const nanoTiny = 6.0;
  static const nano = 4.0;
}

abstract class AppRadius {
  static const small = 12.0;
  static const big = 20.0;
  static const tiny = 6.0;
  static const nano = 4.0;
}

abstract class AppFontSizes {
  static const medium = 16.0;
  static const small = 10.0;
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
  static const headerWithoutControls = 46.0;
  static const controlsSpacing = 20.0;
  static const roundedTopRadius = 15.0;
}

abstract final class SelectRouteConfig {
  static const contentPadding = 5.0;
  static const iconSize = 20.0;
  static const statWidth = 30.0;
}

abstract final class CheckpointsSectionConfig {
  static const contentPadding = 5.0;

  // landmark item
  static const landmarkItemSpacing = 20.0;
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
  static const imageHeight = 200.0;
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

  static const wroclawCenter = LatLng(51.1079, 17.0325);
}

abstract final class LocalizationConfig {
  static const coordProximityThresholdInMeters = 8.0;
  static const loopProximityThresholdInMeters = 100.0;
  static const distanceChangeFilter = 3;
}

abstract final class StatInfoCompactConfig {
  static const circleSize = 44.0;
  static const boxRad = 32.0;
  static const boxPadding = 2.0;
  static const boxLeftOffset = 10.0;
  static const borderWidth = 2.0;
  static const iconPadding = 6.0;
}

abstract final class HomeViewConfig {
  static const double sideMargin = 10;
  static const double commonGap = 30;
  static const double circleAvatarRadius = 36;
  static const double exploreIconSize = 72;
  static const double constrainedTextMaxWidth = 120;
}

abstract final class VerticalButtonConfig {
  static const double iconSize = 84;
  static const double cardMinimumHeight = 225;
  static const double greenHeader = 60;
}

abstract final class RouteListConfig {
  static const double height = 225;
  static const double itemWidth = 180;
  static const double minimumHeightCard = 120;
  static const double defaultSideMargin = 16;
  static const double clipperHeight = 55;
  static const double arrowIconSize = 35;
}

abstract final class SectionAccentConfig {
  static const double height = 28;
  static const double width = 24;
}

abstract final class ProfileViewConfig {
  static const double sideMargin = 10;
  static const double commonGap = 30;
}

abstract final class ProfileProgressBarConfig {
  static const double barHeight = 16;
  static const double clipperHeight = barHeight - borderThickness * 2;
  static const double borderThickness = 2;
}

abstract final class CardListConfig {
  static const double height = 160;
  static const double itemWidth = 160;
  static const double defaultSideMargin = 16;
  static const double iconSize = 64;
}

abstract final class StatCardConfig {
  static const double iconOpacity = 0.85;
}

abstract final class InfoSectionConfig {
  // section title
  static const radius = 15.0;

  // socials
  static const socialIconSize = 35.0;
  static const socialIconCompactSize = 25.0;

  // creator tile
  static const creatorTileWidth = 190.0;
  static const creatorTileHeight = 280.0;
  static const creatorShimmerPhotoHeight = 160.0;
  static const creatorShimmerNameHeight = 18.0;
  static const creatorShimmerNameWidth = 100.0;
  static const creatorShimmerRoleHeight = 14.0;
  static const creatorShimmerRoleWidth = 60.0;
  static const creatorShimmerSocialsHeight = 24.0;
  static const creatorShimmerSocialsWidth = 80.0;
}

abstract final class ErrorWidgetConfig {
  static const iconSize = 80.0;
  static const buttonOutsidePadding = 60.0;
}

abstract final class ShimmerConfig {
  static const millisecounds500 = 500;
  static const shimmerKey = ValueKey("shimmer");
  static const listKey = ValueKey("list");
  static const creatorKey = ValueKey("creator");
  static const profileRoutesKey = ValueKey("profile_routes");
  static final baseColor = Colors.grey.shade300;
  static final highlightColor = Colors.grey.shade100;
}

abstract final class AppBarConfig {
  static const preferredSize = 55.0;
}
