import "package:flutter/material.dart";

import "../../../app/theme/app_theme.dart";

ButtonStyle sharedCardButtonStyle(
  BuildContext context, {
  double minimumHeight = 100,
  bool zeroPadding = false,
  double borderRadius = 20,
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: context.colorScheme.onPrimary,
    elevation: 2,
    padding: zeroPadding ? EdgeInsets.zero : null,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
    minimumSize: Size(double.infinity, minimumHeight),
  );
}
