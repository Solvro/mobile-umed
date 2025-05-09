import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../app/app.dart";
import "../../route_map/repository/route_map_repository.dart";

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key, required this.title});

  final String title;

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("You have pushed the button this many times:"),
            Text("$_counter", style: Theme.of(context).textTheme.headlineMedium),
            // temporary
            OutlinedButton(onPressed: () async => context.router.pushRouteMap(2), child: const Text("Route Map")),
            const TestProviderWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TestProviderWidget extends ConsumerWidget {
  const TestProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(fetchAllRoutesProvider);
    final route_2 = ref.watch(fetchRouteWithIdProvider(2));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        routes.when(
          data: (routes) => Text("Routes:\n$routes"),
          loading: CircularProgressIndicator.new,
          error: (e, _) => Text("Error: $e"),
        ),
        route_2.when(
          data: (route) => Text("\nRoute 2:\n$route"),
          loading: CircularProgressIndicator.new,
          error: (e, _) => Text("Error: $e"),
        ),
      ],
    );
  }
}
