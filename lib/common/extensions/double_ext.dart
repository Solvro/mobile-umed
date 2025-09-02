extension RouteParamsDoubleX on double {
  String inKilometers() {
    return "$this km";
  }

  String inMilliliters() {
    return "${toInt()} ml";
  }
}
