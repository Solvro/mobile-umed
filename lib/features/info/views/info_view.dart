import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:flutter/material.dart";

import "../../../app/app.dart";
import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../common/models/creator.dart";
import "../../../common/models/info_section.dart";
import "../../../common/utils/url_launcher.dart";
import "../../../common/widgets/main_action_button.dart";
import "../widgets/creator_tile.dart";
import "../widgets/section_title.dart";
import "../widgets/socials_section.dart";
import "../widgets/text_info_tile.dart";

class InfoView extends StatelessWidget {
  const InfoView({super.key, required this.creators, required this.infoSections});

  final IList<Creator> creators;
  final IList<InfoSection> infoSections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ...infoSections.map((section) => InfoSectionWidget(infoSection: section)),
          SectionTitle(title: context.l10n.info_creators),
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

class InfoSectionWidget extends StatefulWidget {
  const InfoSectionWidget({super.key, required this.infoSection});

  final InfoSection infoSection;

  @override
  State<InfoSectionWidget> createState() => _InfoSectionWidgetState();
}

class _InfoSectionWidgetState extends State<InfoSectionWidget> {
  Future<void> _tryLaunchUrl(String url) async {
    try {
      await customLaunchUrl(url, context.l10n.errors_launch);
    } on Exception catch (e) {
      if (!mounted) return;
      await context.router.pushFullScreenError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final infoSection = widget.infoSection;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SectionTitle(title: infoSection.title),
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppPaddings.medium,
            top: AppPaddings.tiny,
            left: AppPaddings.medium,
            right: AppPaddings.medium,
          ),
          child:
              infoSection.socials != null
                  ? TextInfoTile(
                    title: infoSection.subtitle,
                    content: infoSection.description,
                    bottomActions:
                        (infoSection.socials != null && infoSection.socials!.onlyWeb)
                            ? MainActionButton(
                              text: context.l10n.info_more_info,
                              onPressed: () => _tryLaunchUrl(infoSection.socials!.webUrl!),
                            )
                            : SocialsSection(compact: false, socials: infoSection.socials!),
                  )
                  : TextInfoTile(title: infoSection.subtitle, content: infoSection.description),
        ),
      ],
    );
  }
}
