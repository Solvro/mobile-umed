import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/theme/app_theme.dart";

class NavBar extends StatefulWidget {
  const NavBar({super.key, this.onItemSelected, required this.selectedIndex});

  final void Function(int index)? onItemSelected;
  final int selectedIndex;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NavBar oldWidget) {
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        _selectedIndex = widget.selectedIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  final List<(IconData, IconData)> _icons = [
    (Icons.home, Icons.home_outlined),
    (Icons.info, Icons.info_outline),
    (Icons.person, Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPaddings.small, vertical: AppPaddings.tiny),
          decoration: BoxDecoration(
            color: context.colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                  color: context.colorScheme.onTertiary.withAlpha(30),
                  blurRadius: 4,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Row(
            spacing: AppPaddings.medium,
            children: List.generate(
              _icons.length,
              (index) => _NavBarItem(
                icon: _icons[index].$2,
                iconSelected: _icons[index].$1,
                isSelected: _selectedIndex == index,
                onPressed: () => setState(() {
                  _selectedIndex = index;
                  widget.onItemSelected?.call(_selectedIndex);
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.icon,
    required this.onPressed,
    required this.isSelected,
    required this.iconSelected,
  });

  final IconData icon;
  final IconData iconSelected;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      highlightColor: context.colorScheme.primary.withAlpha(30),
      icon: Icon(isSelected ? iconSelected : icon,
          size: 26, color: context.colorScheme.secondary),
    );
  }
}
