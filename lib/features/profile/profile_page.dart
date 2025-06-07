import "package:flutter/material.dart";
import "./views/profile_view.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String routeName = "/profile";
  static const String label = "ProfileView";
  static const Icon icon = Icon(Icons.settings);

  @override
  Widget build(BuildContext context) {
    return const ProfileView(title: "profile");
  }
}
