import "package:flutter/material.dart" hide Route;
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:latlong2/latlong.dart";

import "../../app/app.dart";
import "../../common/models/route.dart";
import "../../common/providers/bottom_sheet_providers.dart";
import "../error/error_page.dart";
import "controllers/route_controller.dart" hide Distance;
import "modals/route_completed_modal.dart";
import "providers/locations_provider.dart";
import "providers/route_provider.dart";
import "repository/route_map_repository.dart";
import "services/task_handlers/route_background_task_handler.dart";
import "views/route_map_view.dart";

const distance = Distance();

class RouteMapPage extends ConsumerStatefulWidget {
  const RouteMapPage({super.key, this.id});
  final int? id;

  static const routeName = "/route_map";

  @override
  ConsumerState<RouteMapPage> createState() => _RouteMapPageState();
}

class _RouteMapPageState extends ConsumerState<RouteMapPage> {
  void _initializeState(WidgetRef ref, {Route? route}) {
    ref.read(routeProvider.notifier).state = route;
    ref.read(sheetStateProvider.notifier).state = SheetState.hidden;
    ref.read(passedLocationsProvider.notifier).state = 0;
    ref.read(visitedCountProvider.notifier).resetVisited();
    ref.read(selectedRoutesProvider.notifier).state = [];
  }

  void _initializeBackgroundTracking(WidgetRef ref, BuildContext context, Route? route) {
    if (route != null) {
      FlutterForegroundTask.addTaskDataCallback((data) async => _onReceiveTaskData(data, ref, context, route));
      FlutterForegroundTask.sendDataToTask({
        ForegroundTaskKeys.locations: route.route.map((element) => element.toJson()).toList(),
        ForegroundTaskKeys.checkpoints: route.checkpoints.map((element) => element.toJson()).toList(),
      });
    }
  }

  Future<void> _onReceiveTaskData(Object data, WidgetRef ref, BuildContext context, Route route) async {
    if (data is String) {
      final event = TaskEvent.fromString(data);
      switch (event) {
        case TaskEvent.nextLocationReached:
          ref.read(passedLocationsProvider.notifier).state++;
        case TaskEvent.nextCheckpointReached:
          ref.read(visitedCountProvider.notifier).incrementVisited();
        case TaskEvent.routeCompleted:
          await showDialog<RouteCompletedModal>(context: context, builder: (context) => const RouteCompletedModal());
          await FlutterForegroundTask.stopService();
        case TaskEvent.error:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $data")));
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.id == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeState(ref);
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

    final route = ref.read(routeProvider);

    if (widget.id == null || route != null) {
      return const RouteMapView();
    }

    final routeAsync = ref.watch(fetchRouteWithIdProvider(widget.id!));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (routeAsync is AsyncData) {
        _initializeState(ref, route: routeAsync.value);
      }
    });

    return switch (routeAsync) {
      AsyncData() => const RouteMapView(),
      AsyncError(:final error) => ErrorPage(onBackToHome: context.router.goHome, message: error.toString()),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {

  //   if (id == null) {
  //     return const RouteMapView();
  //   }

  //   final routeAsync = ref.watch(fetchRouteWithIdProvider(id!));

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (routeAsync is AsyncData) {
  //       _initializeState(ref, route: routeAsync.value);
  //     }
  //   });

  //   return switch (routeAsync) {
  //     AsyncData() => const RouteMapView(),
  //     AsyncError(:final error) => ErrorPage(onBackToHome: context.router.goHome, message: error.toString()),
  //     _ => const Center(child: CircularProgressIndicator()),
  //   };
  // }
}
