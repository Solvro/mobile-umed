import "package:flutter/material.dart";

import "../../../app/l10n/l10n.dart";
import "../../../common/models/socials.dart";
import "../../../common/utils/url_launcher.dart";
import "../../../common/widgets/main_action_button.dart";
import "../widgets/section_title.dart";
import "../widgets/socials_section.dart";
import "../widgets/text_info_tile.dart";

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SectionTitle(title: context.l10n.about_app),
          TextInfoTile(
            title: context.l10n.about_app_title,
            content: context.l10n.about_app_content,
            bottomActions: MainActionButton(
              text: context.l10n.more_info,
              onPressed: () async => customLaunchUrl("https://solvro.pwr.edu.pl/en/"),
            ),
          ),
          SectionTitle(title: context.l10n.solvro),
          TextInfoTile(
            title: context.l10n.about_solvro_title,
            content: context.l10n.about_solvro_content,
            bottomActions: const SocialsSection(
              hasTitle: true,
              socials: Socials(webUrl: "https://solvro.pwr.edu.pl/en/"),
            ),
          ),
          SectionTitle(title: context.l10n.umed),
          TextInfoTile(
            title: context.l10n.about_umed_title,
            content: context.l10n.about_umed_content,
            bottomActions: const SocialsSection(
              hasTitle: true,
              socials: Socials(
                webUrl: "https://solvro.pwr.edu.pl/en/",
                email: "https://solvro.pwr.edu.pl/en/",
                githubUrl: "https://solvro.pwr.edu.pl/en/",
                linkedinUrl: "https://solvro.pwr.edu.pl/en/",
              ),
            ),
          ),
          SectionTitle(title: context.l10n.creators),
        ],
      ),
    );
  }
}
