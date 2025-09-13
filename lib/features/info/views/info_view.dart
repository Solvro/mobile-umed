import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";
import "package:wiredash/wiredash.dart";

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
        actions: [
          IconButton(
            icon: const Icon(Icons.feedback_outlined),
            tooltip: context.l10n.app_feedback,
            onPressed: () async {
              await Wiredash.of(context).show(inheritMaterialTheme: true);
            },
          ),
        ],
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
          const FeedbackTile(),
        ],
      ),
    );
  }
}

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium, vertical: AppPaddings.medium),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: const Icon(Icons.feedback_outlined),
          title: Text(context.l10n.info_feedback_title),
          subtitle: Text(context.l10n.info_feedback_subtitle),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: AppPaddings.small, vertical: AppPaddings.nanoTiny),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.small)),
            ),
            onPressed: () async {
              await Wiredash.of(context).show(inheritMaterialTheme: true);
            },
            child: Text(context.l10n.info_feedback_button),
          ),
        ),
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
              infoSection.socialUrls != null
                  ? TextInfoTile(
                    title: infoSection.subtitle,
                    content: infoSection.description,
                    bottomActions:
                        (infoSection.socialUrls != null && infoSection.socialUrls!.onlyWeb)
                            ? MainActionButton(
                              text: context.l10n.info_more_info,
                              onPressed: () async => customLaunchUrl(infoSection.socialUrls!.webUrl!),
                            )
                            : SocialsSection(compact: false, socials: infoSection.socialUrls!),
                  )
                  : TextInfoTile(title: infoSection.subtitle, content: infoSection.description),
        ),
      ],
    );
  }
}
