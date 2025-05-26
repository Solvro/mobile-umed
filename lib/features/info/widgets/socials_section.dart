import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "../../../app/assets/assets.gen.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/models/socials.dart";
import "../../../common/utils/url_launcher.dart";

class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key, required this.socials, this.hasTitle = false});
  final bool hasTitle;
  final Socials socials;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle) Text(style: TextStyle(color: context.colorScheme.primary), context.l10n.follow_us),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (socials.webUrl != null) SocialIconButton(icon: Assets.icons.socialsWeb.sized(), url: socials.webUrl!),
            if (socials.githubUrl != null)
              SocialIconButton(icon: Assets.icons.socialsWeb.sized(), url: socials.githubUrl!),
            if (socials.facebookUrl != null)
              SocialIconButton(icon: Assets.icons.socialsWeb.sized(), url: socials.facebookUrl!),
            if (socials.linkedinUrl != null)
              SocialIconButton(icon: Assets.icons.socialsWeb.sized(), url: socials.linkedinUrl!),
            if (socials.email != null) SocialIconButton(icon: Assets.icons.socialsWeb.sized(), url: socials.email!),
          ],
        ),
      ],
    );
  }
}

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key, required this.icon, required this.url});

  final SvgPicture icon;
  final String url;

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, onPressed: () async => customLaunchUrl(url));
  }
}

extension SvgGenImageX on SvgGenImage {
  SvgPicture sized({double size = InfoSectionConfig.socialIconSize}) {
    return this.svg(width: size, height: size);
  }
}
