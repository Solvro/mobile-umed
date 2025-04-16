import "package:flutter/material.dart";

import "../home/views/home_view.dart";

class OthersPage extends StatelessWidget {
  const OthersPage({super.key});

  static const String routeName = "/others";

  @override
  Widget build(BuildContext context) {
    return const MyHomeView(title: "OthersView");
  }
}
