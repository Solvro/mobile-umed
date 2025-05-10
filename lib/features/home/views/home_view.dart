import "package:flutter/material.dart";
import "../../../common/widgets/home_view_styles.dart";
import "../../../common/widgets/horizontal_routes_list.dart";
import "../../../common/widgets/section_header.dart";
import "./../../../app/l10n/arb/app_localizations.g.dart";
import "./../../../common/data_source/mocks/mock_routes.dart";

const double _commonGap = 30;
const double _iconSize = 84;

class MyHomeView extends StatefulWidget {
  const MyHomeView({super.key, required this.title});

  final String title;

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(loc.common_finished_routes_title, style: const TextStyle(fontWeight: FontWeight.w500)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(children: [SectionHeader(loc.home_nearest_to_you)]),
            RouteListWidget(
              key: const ValueKey("mockRoutesList"),
              routes: mockData,
              onRouteTap: (route) {
                // something happens
              },
            ),

            const SizedBox(height: _commonGap),
            SectionHeader(loc.home_choose_route),

            ElevatedButton(
              style: sharedCardButtonStyle(),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.lightGreen,
                      child: Icon(Icons.explore, color: Colors.white, size: 72),
                    ),
                  ),

                  Flexible(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 120),
                      child: Text(
                        loc.home_start_your_walk,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: _commonGap),

            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: sharedCardButtonStyle(minimumHeight: 80),
                      onPressed: () {},
                      child: Column(
                        // tu Column, bo ikona nad tekstem
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            loc.common_finished_routes,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          const Icon(Icons.auto_graph, size: _iconSize, color: Colors.purpleAccent),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: _commonGap),
                  Expanded(
                    child: ElevatedButton(
                      style: sharedCardButtonStyle(minimumHeight: 80),
                      onPressed: () {},
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            loc.home_learn_more,
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          const Icon(Icons.public, size: _iconSize, color: Colors.lightGreen),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
