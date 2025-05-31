import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../app/config/ui_config.dart";
import "../../../app/l10n/l10n.dart";
import "../../../app/theme/app_theme.dart";
import "../../../common/utils/url_launcher.dart";
import "../../../common/widgets/main_action_button.dart";
import "../repository/info_repository.dart";
import "../widgets/creator_tile.dart";
import "../widgets/section_title.dart";
import "../widgets/socials_section.dart";
import "../widgets/text_info_tile.dart";

class InfoView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final combinedRef = ref.watch(fetchCreatorsAndInfosProvider);

    return ColoredBox(
      color: context.colorScheme.surface,
      child: combinedRef.when(
        data: (value) {
          final creators = value.creators;
          final infoSections = value.infoSections;
          final List<Widget> children = [];

          for (final infoSection in infoSections) {
            children.add(SectionTitle(title: infoSection.title));

            children.add(
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
                                    text: context.l10n.more_info,
                                    onPressed: () async => customLaunchUrl(infoSection.socials!.webUrl!),
                                  )
                                  : SocialsSection(compact: false, socials: infoSection.socials!),
                        )
                        : TextInfoTile(title: infoSection.subtitle, content: infoSection.description),
              ),
            );
          }

          children.add(SectionTitle(title: context.l10n.creators));

          children.add(
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPaddings.medium, vertical: AppPaddings.tiny),
                child: Row(children: creators.map(CreatorTile.new).toList()),
              ),
            ),
          );

          return ListView(children: children);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error loading creators: $error")),
      ),
    );
  }
}
