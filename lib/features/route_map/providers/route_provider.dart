import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../common/models/route.dart";

enum RouteDetailsOption { info, playlist }

final routeProvider = StateProvider<Route?>((ref) => null);

final selectedRouteProvider = StateProvider<Route?>((ref) => null);
