extension DistanceFormatting on int {
  String toDistanceString() {
    if (this < 1000) {
      return "$this m";
    } else {
      return "${(this / 1000).toStringAsFixed(1)} km";
    }
  }
}

extension RouteParamsIntX on int {
  String inMinutes() {
    return "$this min";
  }

  String inHours() {
    return "${this / 60.0} h";
  }

  String inLiters() {
    return "${this / 1000.0} l";
  }

  String inKcal() {
    return "$this kcal";
  }
}
