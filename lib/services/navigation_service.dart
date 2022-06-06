import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateTo(
    String routeName, {
    bool clearBackStack = false,
    dynamic args,
  }) {
    if (clearBackStack) {
      return navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(routeName, (route) => false);
    }
    return navigatorKey.currentState?.pushNamed(routeName, arguments: args);
  }

  Future<dynamic>? clearAllRoutes(String routeName) {
    return navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void goBack() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      return navigatorKey.currentState?.pop();
    }
  }
}
