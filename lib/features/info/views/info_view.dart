import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../common/models/creator.dart";
import "../../../common/models/info_section.dart";
import "../../../common/utils/url_launcher.dart";
import "../../../common/widgets/app_bar.dart";
import "../../../common/widgets/buttons/main_action_button.dart";
import "../../../common/widgets/styling/section_header.dart";
import "../widgets/creator_tile/creator_tile.dart";
import "../widgets/socials_section.dart";
import "../widgets/text_info_tile.dart";

class InfoView extends StatelessWidget {
  const InfoView({super.key, required this.creators, required this.infoSections});

  final IList<Creator> creators;
  final IList<InfoSection> infoSections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: context.l10n.common_app_bar_title_one,
        subtitle: context.l10n.common_app_bar_title_two,
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: AppPaddings.tinySmall, bottom: AppPaddings.veryLarge),
        children: [
          ...infoSections.map((section) => InfoSectionWidget(infoSection: section)),
          SectionHeader(context.l10n.info_creators),
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

class InfoSectionWidget extends StatelessWidget {
  const InfoSectionWidget({super.key, required this.infoSection});

  final InfoSection infoSection;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SectionHeader(infoSection.title),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPaddings.nanoTiny, horizontal: AppPaddings.medium),
          child:
              infoSection.socials != null
                  ? TextInfoTile(
                    title: infoSection.subtitle,
                    content: infoSection.description,
                    bottomActions:
                        (infoSection.socials != null && infoSection.socials!.onlyWeb)
                            ? MainActionButton(
                              text: context.l10n.info_more_info,
                              onPressed: () async => customLaunchUrl(infoSection.socials!.webUrl!),
                            )
                            : SocialsSection(compact: false, socials: infoSection.socials!),
                  )
                  : TextInfoTile(title: infoSection.subtitle, content: infoSection.description),
        ),
      ],
    );
  }
}
