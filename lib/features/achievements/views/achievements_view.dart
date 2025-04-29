import "package:flutter/material.dart";
import "../../../common/models/test_routes_list.dart";
import "../../../common/widgets/horizontal_routes_list.dart";
import "../../../common/widgets/section_header.dart";
import "../../../common/widgets/stat_card.dart";

const double _statWidth = 150;
const double _statHeight = 160;
const double _commonGap = 32;

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key, required this.title});
  final String title;
  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: ConstrainedBox(
              // we force the Column to have the height of the screen
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),

                  // ——— Finished Routes ———
                  const SectionHeader("Ukończone trasy"),
                  RouteListWidget(
                    key: const ValueKey("finishedRoutes"),
                    routes: testRoutes,
                    onRouteTap: (route) {
                      // obsługa tapnięcia
                    },
                  ),

                  const SizedBox(height: _commonGap),

                  // ——— Statictics ———
                  const SectionHeader("Statystyki"),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatCard(value: "12", label: "km", width: _statWidth, height: _statHeight),
                      SizedBox(width: 32),
                      StatCard(value: "999", label: "kcal", width: _statWidth, height: _statHeight),
                    ],
                  ),

                  const SizedBox(height: _commonGap),

                  // ——— Achievements ———
                  const SectionHeader("Osiągnięcia"),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatCard(value: "🏆", label: "Osiągnięcie", width: _statWidth, height: _statHeight),
                      SizedBox(width: 32),
                      StatCard(value: "🏆", label: "Osiągnięcie", width: _statWidth, height: _statHeight),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
