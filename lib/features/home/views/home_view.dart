import "package:flutter/material.dart";
import "../../../common/models/test_routes_list.dart";
import "../../../common/widgets/home_view_styles.dart";
import "../../../common/widgets/horizontal_routes_list.dart";
import "../../../common/widgets/section_header.dart";

const double _commonGap = 32;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Zdrowie gra pierwsze skrzypce", style: TextStyle(fontWeight: FontWeight.w500)),
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
            const Row(children: [SectionHeader("Najbliżej Ciebie!")]),
            RouteListWidget(
              key: const ValueKey("testRoutesList"),
              routes: testRoutes,
              onRouteTap: (route) {
                // something happens
              },
            ),

            const SizedBox(height: _commonGap),
            const SectionHeader("Wybierz trasę!"),

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
                      child: const Text(
                        "Rozpocznij swój spacer",
                        style: TextStyle(fontSize: 16, color: Colors.black),
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
                      child: const Column(
                        // tu Column, bo ikona nad tekstem
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            "Ukończone trasy",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Icon(Icons.auto_graph, size: _iconSize, color: Colors.purpleAccent),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: _commonGap),
                  Expanded(
                    child: ElevatedButton(
                      style: sharedCardButtonStyle(minimumHeight: 80),
                      onPressed: () {},
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 8),
                          Text(
                            "Dowiedz się więcej",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Spacer(),
                          Icon(Icons.public, size: _iconSize, color: Colors.lightGreen),
                          Spacer(),
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
