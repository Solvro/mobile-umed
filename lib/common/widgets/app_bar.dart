import "package:flutter/material.dart";
//import "package:wiredash/wiredash.dart";

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
      /*[
        ...?actions,
        IconButton(
          icon: const Icon(Icons.feedback_outlined),
          tooltip: context.l10n.app_feedback, // Dodaj do l10n odpowiedni tekst
          onPressed: () async {
            await Wiredash.of(context).show(inheritMaterialTheme: true);
          },
        ),
      ],*/
      leading: Padding(
        padding: const EdgeInsets.all(AppPaddings.tiny),
        child: Assets.icons.logoNoBg.svg(fit: BoxFit.cover),
      ),
    );
  }
}
