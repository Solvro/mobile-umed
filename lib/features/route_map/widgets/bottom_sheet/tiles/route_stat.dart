import "package:flutter/widgets.dart";
import "package:flutter_svg/svg.dart";

import "../../../../../app/config/ui_config.dart";
import "../../../../../app/theme/app_theme.dart";

class RouteStat extends StatelessWidget {
  const RouteStat({super.key, required this.icon, required this.comment});

  final SvgPicture icon;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Column(
        children: [
          icon,
          const SizedBox(height: 8),
          Text(
            comment,
            style: context.textTheme.bodySmall?.copyWith(fontSize: SelectRouteConfig.smallFontSize),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
