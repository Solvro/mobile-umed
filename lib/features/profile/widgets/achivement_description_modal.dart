import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/models/achievement.dart";
import "../../../common/widgets/modals/info_modal.dart";

class AchievementDescriptionModal extends StatelessWidget {
  const AchievementDescriptionModal({super.key, required this.achievement});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return InfoModal(
      title: achievement.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppPaddings.small,
        children: [
          Icon(achievement.iconData, color: Color(achievement.iconColor), size: ProfileViewConfig.achievementsIconSize),
          Text(achievement.description, style: context.textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(width: double.infinity),
        ],
      ),
    );
  }
}
