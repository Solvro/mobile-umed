import "package:flutter_riverpod/flutter_riverpod.dart";

enum SheetMode { half, expanded }

enum SheetState { hidden, visible }

final sheetModeProvider = StateProvider<SheetMode>((ref) => SheetMode.half);

final sheetStateProvider = StateProvider<SheetState>((ref) => SheetState.hidden);

final sheetTriggerProvider = StateProvider<bool>((ref) => false);
