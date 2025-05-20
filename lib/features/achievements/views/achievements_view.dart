import "package:flutter/material.dart";
import "../../../common/widgets/horizontal_routes_list.dart";
import "../../../common/widgets/progressbar.dart";
import "../../../common/widgets/section_header.dart";
import "../../../common/widgets/stat_card.dart";
import "./../../../app/l10n/arb/app_localizations.g.dart";
import "./../../../common/data_source/mocks/mock_routes.dart";

const double _statWidth = 150;
const double _statHeight = 160;
const double _commonGap = 28;
double _progress = 0.3;

class AchievementsView extends StatefulWidget {
  const AchievementsView({super.key, required this.title});
  final String title;
  @override
  State<AchievementsView> createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
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
                  SectionHeader(loc.common_finished_routes),
                  ProgressBar(progress: _progress),
                  const SizedBox(height: _commonGap),

                  RouteListWidget(
                    key: const ValueKey("finishedRoutes"),
                    routes: mockData,
                    onRouteTap: (route) {
                      // obsługa tapnięcia
                    },
                  ),

                  const SizedBox(height: _commonGap),

                  // ——— Statictics ———
                  SectionHeader(loc.achievements_statistics),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StatCard(value: "12", label: loc.achievements_kilometers, width: _statWidth, height: _statHeight),
                      const SizedBox(width: 32),
                      StatCard(value: "999", label: loc.achievements_kcal, width: _statWidth, height: _statHeight),
                    ],
                  ),

                  const SizedBox(height: _commonGap),

                  // ——— Achievements ———
                  SectionHeader(loc.achievements_achievements),
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
