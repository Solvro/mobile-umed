import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../models/achievement.dart";
import "../../models/stat.dart";

final mockStats =
    [
      Stat(id: 1, value: "10.5 km", iconData: Icons.directions_walk, iconColor: Colors.green.toARGB32()),
      Stat(id: 2, value: "500 kcal", iconData: Icons.local_fire_department, iconColor: Colors.red.toARGB32()),
      Stat(id: 3, value: "2 L", iconData: Icons.water_drop, iconColor: Colors.blue.toARGB32()),
      Stat(id: 4, value: "3 h", iconData: Icons.schedule, iconColor: Colors.orange.toARGB32()),
    ].lock;

final mockAchievements =
    [
      Achievement(
        id: 1,
        value: "Pierwszy krok",
        description: "Przejdź swoją pierwszą trasę w aplikacji.",
        iconData: Icons.directions_walk,
        iconColor: Colors.green.toARGB32(),
      ),
      Achievement(
        id: 2,
        value: "Turysta",
        description: "Ukończ trzy różne trasy o sumarycznej długości większej niż sześć kilometrów.",
        iconData: Icons.nordic_walking,
        iconColor: Colors.black.toARGB32(),
      ),
      Achievement(
        id: 2,
        value: "Lubię wracać tam...",
        description: "Ukończ tą samą trasę dwa razy.",
        iconData: Icons.timelapse,
        iconColor: Colors.brown.toARGB32(),
      ),
      Achievement(
        id: 3,
        value: "Zasłuchany",
        description: "Przejdź wszystkie trasy dostępne w aplikacji conajmniej raz.",
        iconData: Icons.music_note,
        iconColor: Colors.blue.toARGB32(),
      ),
    ].lock;
