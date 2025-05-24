import "package:flutter/material.dart";
import "package:flutter_map_tile_caching/flutter_map_tile_caching.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

import "app/app.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FMTCObjectBoxBackend().initialise();
  runApp(const ProviderScope(child: MyApp()));
}
