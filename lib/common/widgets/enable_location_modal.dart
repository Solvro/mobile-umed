import "package:flutter/material.dart";
import "../../../common/widgets/info_modal.dart";
import "../../app/config/ui_config.dart";
import "../../app/l10n/l10n.dart";

class EnableLocationModal extends StatelessWidget {
  const EnableLocationModal({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoModal(
      title: context.l10n.enable_location_services,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(AppPaddings.tinySmall),
        child: Text(context.l10n.enable_location_services_description),
      ),
    );
  }
}
