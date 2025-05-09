import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../common/controllers/route_controller.dart";

class RouteInfoSection extends ConsumerWidget {
  const RouteInfoSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timer = ref.watch(routeTimerProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: _decoration(),
            alignment: Alignment.center,
            child: Text(_formatDuration(timer)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: _decoration(),
                child: const Text("1000"),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: _decoration(),
                child: const Text("6fd"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

BoxDecoration _decoration() {
  return BoxDecoration(
    border: Border.all(color: Colors.green, width: 2),
    borderRadius: const BorderRadius.all(Radius.circular(22)),
  );
}

String _formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;
  return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}
