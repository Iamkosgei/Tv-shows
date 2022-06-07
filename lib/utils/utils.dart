import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations? getGlobalApplocalization() {
  return AppLocalizations.of(
      inject.get<NavigationService>().navigatorKey.currentState!.context);
}
