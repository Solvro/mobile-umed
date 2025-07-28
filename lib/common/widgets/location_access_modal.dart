import "package:flutter/material.dart";
import "../../../common/widgets/info_modal.dart";
import "../../app/app.dart";
import "../../app/config/ui_config.dart";
import "../../app/l10n/l10n.dart";
import "../utils/location_service.dart";

class LocationAccessModal extends StatelessWidget {
  const LocationAccessModal({super.key, required this.isLocationServiceEnabled});

  final bool isLocationServiceEnabled;

  @override
  Widget build(BuildContext context) {
    return InfoModal(
      title: isLocationServiceEnabled ? context.l10n.allow_access_to_location : context.l10n.enable_location_services,
      backButtonText: context.l10n.go_to_location_settings,
      child: Padding(
        padding: const EdgeInsetsGeometry.all(AppPaddings.tinySmall),
        child: Text(
          isLocationServiceEnabled
              ? context.l10n.allow_access_to_location_description
              : context.l10n.enable_location_services_description,
        ),
      ),
      onClose: () async {
        context.router.pop();
        await LocationService.goToSettings();
      },
    );
  }
}
