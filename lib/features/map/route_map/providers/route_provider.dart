import "dart:collection";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../common/models/route.dart";

enum RouteDetailsOption { info, playlist }

final routeProvider = StateProvider<Route?>((ref) => null);
final routeIdProvider = StateProvider<int?>((ref) => 0);

final expandedRoutesProvider = StateProvider<LinkedHashSet<Route>>((ref) => LinkedHashSet());
