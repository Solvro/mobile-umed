import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../features/map/route_map/repository/route_map_repository.dart";
import "../../models/achievement.dart";
import "../../providers/completed_routes_provider.dart";

part "achievments_repository.g.dart";

// These are hardcoded for now, but we don't need to fetch them from a server or database in the future

@riverpod
IList<Achievement> achievementRepository(Ref ref) {
  return [
    Achievement(
      id: 1,
      value: "Pierwszy krok",
      description: "Przejdź swoją pierwszą trasę w aplikacji.",
      iconData: Icons.directions_walk,
      iconColor: Colors.green.toARGB32(),
      isAchieved: (ref) async {
        final completedRoutes = await ref.read(completedRoutesProvider.future);
        return completedRoutes.isNotEmpty;
      },
    ),
    Achievement(
      id: 2,
      value: "Turysta",
      description: "Ukończ trzy różne trasy o sumarycznej długości większej niż sześć kilometrów.",
      iconData: Icons.nordic_walking,
      iconColor: Colors.black.toARGB32(),
      isAchieved: (ref) async {
        final completedRoutes = await ref.read(completedRoutesProvider.future);
        final uniqueRoutes = completedRoutes.map((e) => e.routeId).toSet();
        final double totalDistance = completedRoutes.fold(0, (sum, r) => sum + r.distance);
        return uniqueRoutes.length >= 3 && totalDistance > 6;
      },
    ),
    Achievement(
      id: 2,
      value: "Lubię wracać tam...",
      description: "Ukończ tą samą trasę dwa razy.",
      iconData: Icons.timelapse,
      iconColor: Colors.brown.toARGB32(),
      isAchieved: (ref) async {
        // TODO(tt): implement
        return false;
      },
    ),
    Achievement(
      id: 3,
      value: "Zasłuchany",
      description: "Przejdź wszystkie trasy dostępne w aplikacji conajmniej raz.",
      iconData: Icons.music_note,
      iconColor: Colors.blue.toARGB32(),
      isAchieved: (ref) async {
        final completedRoutes = await ref.read(completedRoutesProvider.future);
        final allRoutes = await ref.read(fetchAllRoutesProvider.future);
        final completedRouteIds = completedRoutes.map((e) => e.routeId).toSet();
        final allRouteIds = allRoutes.map((e) => e.id).toSet();
        return allRouteIds.difference(completedRouteIds).isEmpty && allRouteIds.isNotEmpty;
      },
    ),
  ].lock;
}
