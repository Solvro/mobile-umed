import "dart:collection";
import "package:flutter/material.dart" hide Route;
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../app/app.dart";
import "../../../common/models/route.dart";
import "../../../common/providers/bottom_sheet_providers.dart";
import "../../error/error_page.dart";
import "controllers/route_controller.dart" hide Distance;
import "providers/locations_provider.dart";
import "providers/route_provider.dart";
import "repository/route_map_repository.dart";
import "services/task_handlers/foreground_task_service.dart";
import "services/task_handlers/route_foreground_task_handler.dart";
import "views/route_map_view.dart";

class RouteMapPage extends ConsumerStatefulWidget {
  const RouteMapPage({super.key, required this.id});
  final int id;

  static const routeName = "/route_map";

  @override
  ConsumerState<RouteMapPage> createState() => _RouteMapPageState();
}

class _RouteMapPageState extends ConsumerState<RouteMapPage> {
  void _initializeState(WidgetRef ref, Route route) {
    ref.read(routeProvider.notifier).state = route;
    ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
    ref.read(sheetModeProvider.notifier).state = SheetMode.half;
    ref.read(passedLocationsProvider.notifier).state = 0;
    ref.read(visitedCountProvider.notifier).resetVisited();
    ref.read(expandedRoutesProvider.notifier).state = LinkedHashSet();
  }

  void _initializeBackgroundTracking(WidgetRef ref, BuildContext context, Route? route) {
    if (route != null) {
      final handler = ref.read(foregroundServiceProvider);

      FlutterForegroundTask.addTaskDataCallback((data) async {
        if (!mounted) return;
        await handler.handleTaskData(data, route, context);
      });

      FlutterForegroundTask.sendDataToTask({
        ForegroundTaskKeys.locations: route.route.map((e) => e.toJson()).toList(),
        ForegroundTaskKeys.checkpoints: route.checkpoints.map((e) => e.toJson()).toList(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Route?>(routeProvider, (previous, next) {
      if (next != null && mounted) {
        _initializeBackgroundTracking(ref, context, next);
      }
    });

    final routeAsync = ref.watch(fetchRouteWithIdProvider(widget.id));

    ref.listen<AsyncValue<Route>>(fetchRouteWithIdProvider(widget.id), (prev, next) {
      _initializeState(ref, next.value!);
    });

    return switch (routeAsync) {
      AsyncData(:final value) => RouteMapView(route: value),
      AsyncError(:final error) => ErrorPage(onBackToHome: context.router.goHome, message: error.toString()),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
