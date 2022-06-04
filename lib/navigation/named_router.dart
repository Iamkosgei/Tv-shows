import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/navigation/pages.dart';
import 'package:flutter_tv_shows/ui/login_page/login_page.dart';
import 'package:flutter_tv_shows/ui/movie_list_page/movie_list_page.dart';
import 'package:flutter_tv_shows/ui/splash_page/splash_page.dart';

Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );

    case splashPage:
      return MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
    case movieListPage:
      return MaterialPageRoute(
        builder: (context) => const MovieListPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const SplashPage(),
      );
  }
}
