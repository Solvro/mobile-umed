import "package:flutter/widgets.dart";
import "package:readmore/readmore.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";

class LabelValuePair extends StatelessWidget {
  const LabelValuePair({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: context.textTheme.headlineMedium
                  ?.copyWith(fontSize: AppFontSizes.medium)),
          ReadMoreText(
            value,
            trimLength: 150,
            trimCollapsedText: context.l10n.read_more,
            trimExpandedText: context.l10n.hide,
            style: context.textTheme.bodyLarge
                ?.copyWith(fontSize: AppFontSizes.medium),
          ),
        ],
      ),
    );
  }
}
