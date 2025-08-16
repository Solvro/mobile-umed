import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "../../../app/assets/assets.gen.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/models/socials.dart";
import "social_icon_button.dart";

class SocialsSection extends StatelessWidget {
  const SocialsSection({super.key, required this.socials, this.compact = true});
  final bool compact;
  final Socials socials;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!compact && socials.hasSocials) Text(context.l10n.info_follow_us, style: context.textTheme.titleSmall),
        Row(
          mainAxisAlignment: compact ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
          children: [
            if (socials.webUrl != null)
              SocialIconButton(icon: Assets.icons.internet.sized(compact: compact), url: socials.webUrl!),
            if (socials.githubUrl != null)
              SocialIconButton(icon: Assets.icons.github.sized(compact: compact), url: socials.githubUrl!),
            if (socials.facebookUrl != null)
              SocialIconButton(icon: Assets.icons.facebook.sized(compact: compact), url: socials.facebookUrl!),
            if (socials.linkedinUrl != null)
              SocialIconButton(icon: Assets.icons.linkedin.sized(compact: compact), url: socials.linkedinUrl!),
            if (socials.emailAddress != null)
              SocialIconButton(icon: Assets.icons.email.sized(compact: compact), url: socials.emailAddress!),
          ],
        ),
      ],
    );
  }
}

extension SvgGenImageX on SvgGenImage {
  SvgPicture sized({required bool compact}) {
    final size = compact ? InfoSectionConfig.socialIconCompactSize : InfoSectionConfig.socialIconSize;
    return this.svg(width: size, height: size);
  }
}
