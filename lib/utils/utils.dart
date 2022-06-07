import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';

BuildContext? getGlobalApplicationContext() {
  return inject.get<NavigationService>().navigatorKey.currentState?.context;
}
