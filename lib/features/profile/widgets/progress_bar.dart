import "package:flutter/material.dart";
import "../../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";
import "../../../app/theme/color_consts.dart";

class ProgressBar extends StatelessWidget {
  final double progress;
  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small, vertical: AppPaddings.tinySmall),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: ProfileProgressBarConfig.barHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConsts.borderGray, width: ProfileProgressBarConfig.borderThickness),
                    borderRadius: BorderRadius.circular(AppRadius.small),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: ProfileProgressBarConfig.borderThickness,
                    left: ProfileProgressBarConfig.borderThickness,
                    right: ProfileProgressBarConfig.borderThickness,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.small),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: ProfileProgressBarConfig.clipperHeight,
                      backgroundColor: context.colorScheme.onSecondary,
                      valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppPaddings.tinySmall),
          Text("${(progress * 100).toInt()}%", style: context.textTheme.headlineLarge),
        ],
      ),
    );
  }
}
