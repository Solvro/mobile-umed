import "package:flutter_riverpod/flutter_riverpod.dart";

enum SheetMode { half, expanded }

final sheetModeProvider = StateProvider<SheetMode>((ref) => SheetMode.half);
