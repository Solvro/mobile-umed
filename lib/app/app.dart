import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "../common/providers/completed_routes_provider.dart";
import "../common/utils/location_service.dart";
import "../common/widgets/modals/location_access_modal.dart";
import "../features/dashboard/dashboard_page.dart";
import "../features/debug_playground/debug_playground.dart";
import "../features/error/error_page.dart";
import "../features/home/home_page.dart";
import "../features/info/info_page.dart";
import "../features/init/app_init_page.dart";
import "../features/profile/profile_page.dart";
import "../features/route_map/route_map_page.dart";
import "../features/route_map/services/task_handlers/foreground_task_service.dart";
import "l10n/arb/app_localizations.g.dart";
import "theme/app_theme.dart";

part "router.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(tomasz-trela): move this to logic layer
    final appTheme = AppTheme();

    return _EagerInitialization(
      child: MaterialApp.router(
        title: "Pierwsze Skrzypce",
        theme: appTheme.light,
        darkTheme: appTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  final Widget child;

  const _EagerInitialization({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(completedRoutesProvider);

    return child;
  }
}
