import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "../../../app/theme/app_theme.dart";
import "../../app/config/ui_config.dart";

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final List<Widget>? actions;

  const CommonAppBar({super.key, required this.title, required this.subtitle, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(AppBarConfig.preferredSize);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colorScheme.onSecondary,
      elevation: 4,
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.10),
      child: SafeArea(
        child: Container(
          height: preferredSize.height - AppPaddings.small,
          decoration: BoxDecoration(color: context.colorScheme.onSecondary),
          padding: const EdgeInsets.symmetric(horizontal: AppPaddings.big),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: AppBarConfig.imageSize,
                  height: AppBarConfig.imageSize,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: SvgPicture.asset("assets/icons/logoNoBg.svg", fit: BoxFit.cover),
                ),
              ),
              Center(
                child: Text(
                  "$title\n$subtitle",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: context.colorScheme.secondary),
                  textAlign: TextAlign.center,
                ),
              ),
              if (actions != null)
                Align(alignment: Alignment.centerRight, child: Row(mainAxisSize: MainAxisSize.min, children: actions!)),
            ],
          ),
        ),
      ),
    );
  }
}
