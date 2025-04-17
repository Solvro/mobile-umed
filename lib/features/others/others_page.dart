import "package:flutter/material.dart";

import "../home/views/home_view.dart";

class OthersPage extends StatelessWidget {
  const OthersPage({super.key});

  static const String routeName = "/others";
  static const String label = "OthersView";
  static const Icon icon = Icon(Icons.settings);

  @override
  Widget build(BuildContext context) {
    return const MyHomeView(title: label);
  }
}
