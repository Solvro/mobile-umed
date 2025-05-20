import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../app/app.dart";

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key, required this.navigationShell, required this.items})
    : super(key: key ?? const ValueKey("DashboardPage"));
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
      floatingActionButton:
          kDebugMode
              ? FloatingActionButton(onPressed: context.router.pushPlayground, child: const Icon(Icons.play_arrow))
              : null,
    );
  }
}

typedef NavItem = ({String label, Icon icon});
