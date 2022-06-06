import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/navigation/named_router.dart';
import 'package:flutter_tv_shows/navigation/pages.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_tv_shows/utils/bloc_observer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tv_shows/utils/extensions.dart';

import 'configs/themes.dart';

Future<void> main() async {
  initLogging();
  await setUpLocator();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

void initLogging() {
  Fimber.plantTree(DebugTree());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${context.loc?.tvShow}',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('hr', ''),
      ],
      theme: CustomTheme.lightTheme,
      onGenerateRoute: generateRoute,
      initialRoute: splashPage,
      navigatorKey: inject.get<NavigationService>().navigatorKey,
    );
  }
}
