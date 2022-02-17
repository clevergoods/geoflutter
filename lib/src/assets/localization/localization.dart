import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations t(BuildContext context) {
  AppLocalizations localizations = AppLocalizations.of(context)!;
  return localizations;
}

class Localization {
  static final all = [
    const Locale('en'),
    const Locale('ru'),
  ];
}