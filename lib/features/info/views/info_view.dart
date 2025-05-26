import "package:flutter/material.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../common/models/creator.dart";
import "../../../common/models/socials.dart";
import "../../../common/utils/url_launcher.dart";
import "../../../common/widgets/main_action_button.dart";
import "../widgets/creator_tile.dart";
import "../widgets/section_title.dart";
import "../widgets/socials_section.dart";
import "../widgets/text_info_tile.dart";

class InfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final creators = [
      const Creator(id: 1, sort: 1, firstName: "Test", lastName: "jkfd", role: "Developer"),
      const Creator(id: 1, sort: 1, firstName: "Ania", lastName: "Frania", role: "Developer"),
      const Creator(id: 1, sort: 1, firstName: "Jakbu", lastName: "Sliman", role: "Developer"),
      const Creator(id: 1, sort: 1, firstName: "dhsfl", lastName: "Uksdha", role: "Developer"),
    ];
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
          ).withStandardInfoPadding(),

          SectionTitle(title: context.l10n.solvro),
          TextInfoTile(
            title: context.l10n.about_solvro_title,
            content: context.l10n.about_solvro_content,
            bottomActions: const SocialsSection(
              compact: false,
              socials: Socials(id: 2, webUrl: "https://solvro.pwr.edu.pl/en/"),
            ),
          ).withStandardInfoPadding(),
          SectionTitle(title: context.l10n.umed),
          TextInfoTile(
            title: context.l10n.about_umed_title,
            content: context.l10n.about_umed_content,
            bottomActions: const SocialsSection(
              compact: false,
              socials: Socials(
                id: 1,
                webUrl: "https://solvro.pwr.edu.pl/en/",
                email: "https://solvro.pwr.edu.pl/en/",
                githubUrl: "https://solvro.pwr.edu.pl/en/",
                linkedinUrl: "https://solvro.pwr.edu.pl/en/",
              ),
            ),
          ).withStandardInfoPadding(),
          SectionTitle(title: context.l10n.creators),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium, vertical: AppPaddings.tiny),
              child: Row(children: creators.map(CreatorTile.new).toList()),
            ),
          ),
        ],
      ),
    );
  }
}

extension PaddedWidgets on Widget {
  Widget withStandardInfoPadding() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPaddings.medium,
        top: AppPaddings.tiny,
        left: AppPaddings.medium,
        right: AppPaddings.medium,
      ),
      child: this,
    );
  }
}
