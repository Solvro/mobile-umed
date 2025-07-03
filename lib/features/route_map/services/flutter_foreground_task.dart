import "package:flutter_foreground_task/flutter_foreground_task.dart";
import "task_handlers/route_background_task_handler.dart";

@pragma("vm:entry-point")
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}
