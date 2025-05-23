import "package:flutter/material.dart";
import "./views/home_view.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String routeName = "/home";
  static const String label = "HomeView";
  static const Icon icon = Icon(Icons.home);

  @override
  Widget build(BuildContext context) {
    return const MyHomeView(title: "Strona główna");
  }
}
