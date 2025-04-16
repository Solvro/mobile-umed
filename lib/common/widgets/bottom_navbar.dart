import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key, required this.navigationShell}) : super(key: key ?? const ValueKey("BottomNavbar"));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: "Home", icon: Icon(Icons.home)),
          NavigationDestination(label: "Achievements", icon: Icon(Icons.pie_chart_outline_sharp)),
          NavigationDestination(label: "Other", icon: Icon(Icons.settings)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
