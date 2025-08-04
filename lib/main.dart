import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:shared_preferences/shared_preferences.dart";
import "app/app.dart";
import "app/config/env.dart";
import "app/wiredash.dart";
import "common/utils/location_service.dart";
import "common/utils/storage_service.dart";
import "features/route_map/services/task_handlers/foreground_task_service.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  await _requestPermissions();

  if (!kReleaseMode) {
    return runMyApp();
  } else {
    await SentryFlutter.init((options) {
      options.dsn = Env.bugsinkDsn;
      options.sendDefaultPii = true;
      options.tracesSampleRate = 0;
    }, appRunner: runMyApp);
  }
}

Future<void> _requestPermissions() async {
  await LocationService.requestPermissions();
  await MyFlutterForegroundTask.requestPermissions();
}

Future<void> runMyApp() async {
  final prefs = await SharedPreferences.getInstance();
  final storage = StorageService(prefs);

  runApp(
    ProviderScope(
      overrides: [storageServiceProvider.overrideWithValue(storage)],
      child: const ProdWiredash(child: WithForegroundTask(child: MyApp())),
    ),
  );
}
