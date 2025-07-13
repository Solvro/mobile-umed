import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

import "../../../common/utils/url_launcher.dart";

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key, required this.icon, required this.url});

  final SvgPicture icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: () => customLaunchUrl(url));
  }
}
