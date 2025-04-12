import "package:flutter/material.dart";

import "arb/app_localizations.g.dart";

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
