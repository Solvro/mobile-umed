import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../features/achievements/achievements_page.dart";
import "../features/dashboard/dashboard_page.dart";
import "../features/home/home_page.dart";
import "../features/others/others_page.dart";
import "../features/route_map/route_map_page.dart";
import "../theme/app_theme.dart";
import "l10n/arb/app_localizations.g.dart";

part "router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Flutter Demo",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const AppTheme().colorTheme.green)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
