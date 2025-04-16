import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "../common/widgets/bottom_navbar.dart";
import "../features/achievements/achievements_page.dart";
import "../features/home/home_page.dart";
import "../features/others/others_page.dart";
import "l10n/arb/app_localizations.g.dart";

part "router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Flutter Demo",
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}
