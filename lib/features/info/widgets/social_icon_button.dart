import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../app/app.dart";
import "../../../app/l10n/l10n.dart";
import "../../../common/utils/url_launcher.dart";

class SocialIconButton extends StatefulWidget {
  const SocialIconButton({super.key, required this.icon, required this.url});

  final SvgPicture icon;
  final String url;

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(icon: widget.icon, onPressed: _tryLaunchUrl);
  }

  Future<void> _tryLaunchUrl() async {
    try {
      await customLaunchUrl(widget.url, context.l10n.errors_launch);
    } on Exception catch (e) {
      if (!mounted) return;
      await context.router.pushFullScreenError(e.toString());
    }
  }
}
