import "package:flutter/material.dart";
import "../../../common/widgets/section_header.dart";
import "./home_view_styles.dart";
import "./test_routes_list.dart";

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
            const Row(
              children: [
                SectionHeader("Najbliżej Ciebie!"), // domyślne wymiary i kolor
              ],
            ),
            const SizedBox(height: 20),

            // Scrollowana lista tras z danymi testowymi
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: testRoutes.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  final route = testRoutes[index];
                  return SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: sharedCardButtonStyle(minimumSize: 120, zeroPadding: true),
                      onPressed: () {
                        // Navigator.push lub showDialog z route.id
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              route.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.broken_image, size: 48, color: Colors.grey));
                              },
                            ),
                            // półprzezroczysty overlay i nazwa
                            Container(
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black45],
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                              child: Text(
                                route.name,
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            const Row(
              children: [
                SectionHeader("Wybierz trasę!"), // domyślne wymiary i kolor
              ],
            ),

            const SizedBox(height: 10),

            // Przycisk rozpocznij swój spacer – biały card z zielonym accentem
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

            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: sharedCardButtonStyle(minimumSize: 80),
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
                          Icon(Icons.auto_graph, size: 84, color: Colors.purpleAccent),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: ElevatedButton(
                      style: sharedCardButtonStyle(minimumSize: 80),
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
                          Icon(Icons.public, size: 84, color: Colors.lightGreen),
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
