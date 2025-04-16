import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({Key? key, required this.navigationShell, required this.items})
    : super(key: key ?? const ValueKey("BottomNavbar"));
  final StatefulNavigationShell navigationShell;
  final List<NavItem> items;

  void _goBranch(int index) {
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations:
            items.map((item) {
              return NavigationDestination(label: item.label, icon: item.icon);
            }).toList(),
        onDestinationSelected: _goBranch,
      ),
    );
  }
}

class NavItem {
  final String label;
  final Icon icon;

  const NavItem({required this.label, required this.icon});
}
