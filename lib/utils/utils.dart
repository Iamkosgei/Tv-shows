import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations? getGlobalApplocalization() {
  return navigatorKey.currentState?.context != null
      ? AppLocalizations.of(navigatorKey.currentState!.context)
      : null;
}
