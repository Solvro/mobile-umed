import "package:flutter/material.dart";

/// Common button style
ButtonStyle sharedCardButtonStyle({double minimumSize = 100, bool zeroPadding = false}) {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 2,
    padding: zeroPadding ? EdgeInsets.zero : null,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    minimumSize: Size(double.infinity, minimumSize),
  );
}
