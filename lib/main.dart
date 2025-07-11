import "package:flutter/material.dart";
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "app/app.dart";
import "common/utils/location_service.dart";
import "features/route_map/widgets/map/route_map_widget.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await _requestPermissions();
  runApp(const ProviderScope(child: WithForegroundTask(child: MyApp())));
}

Future<void> _requestPermissions() async {
  await LocationService.requestPermissions();
  await MyFlutterForegroundTask.requestPermissions();
}
