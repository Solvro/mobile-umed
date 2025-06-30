import "package:flutter/material.dart";
import "package:flutter_foreground_task/flutter_foreground_task.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "app/app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterForegroundTask.initCommunicationPort();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  runApp(const ProviderScope(child: WithForegroundTask(child: MyApp())));
}
