import "package:flutter/material.dart";
import "./views/achievements_view.dart";

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  static const String routeName = "/achievements";
  static const String label = "AchievementsView";
  static const Icon icon = Icon(Icons.pie_chart);

  @override
  Widget build(BuildContext context) {
    return const AchievementsView(title: "AchievementsView");
  }
}
