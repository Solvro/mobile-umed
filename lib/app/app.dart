import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../features/dashboard/dashboard_page.dart";
import "../features/debug_playground/debug_playground.dart";
import "../features/home/home_page.dart";
import "../features/others/others_page.dart";
import "../features/profile/profile_page.dart";
import "../features/route_map/route_map_page.dart";
import "l10n/arb/app_localizations.g.dart";
import "theme/app_theme.dart";

part "router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(tomasz-trela): move this to logic layer
    final appTheme = AppTheme();
    return MaterialApp.router(
      title: "Flutter Demo",
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
