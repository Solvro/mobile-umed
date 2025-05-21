import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../../app/app.dart";
import "../../app/config/ui_config.dart";
import "widgets/nav_bar.dart";

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key, required this.navigationShell}) : super(key: key ?? const ValueKey("DashboardPage"));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Positioned(
            bottom: AppPaddings.horizontalSmall,
            left: 0,
            right: 0,
            child: SafeArea(
              child: NavBar(onItemSelected: navigationShell.goBranch, selectedIndex: navigationShell.currentIndex),
            ),
          ),
        ],
      ),
      floatingActionButton:
          kDebugMode
              ? FloatingActionButton(onPressed: context.router.pushPlayground, child: const Icon(Icons.play_arrow))
              : null,
    );
  }
}
