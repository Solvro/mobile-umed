import "package:flutter/material.dart";

import "../home/views/home_view.dart";

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  static const String routeName = "/achievements";

  @override
  Widget build(BuildContext context) {
    return const MyHomeView(title: "AchievementsView");
  }
}
