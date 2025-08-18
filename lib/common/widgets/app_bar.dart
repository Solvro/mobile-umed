import "package:flutter/material.dart";

import "../../../app/theme/app_theme.dart";
import "../../app/assets/assets.gen.dart";
import "../../app/config/ui_config.dart";
import "../../app/l10n/l10n.dart";

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const CommonAppBar({super.key, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(AppBarConfig.preferredSize);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        context.l10n.common_app_bar_title,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: context.colorScheme.secondary),
      ),
      centerTitle: true,
      backgroundColor: context.colorScheme.surface,
      elevation: 4,
      actions: actions,
      leading: Padding(
        padding: const EdgeInsets.all(AppPaddings.tiny),
        child: Assets.icons.logoNoBg.svg(fit: BoxFit.cover),
      ),
    );
  }
}
