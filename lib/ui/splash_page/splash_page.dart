import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tv_shows/configs/assets.dart';
import 'package:flutter_tv_shows/configs/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SvgPicture.asset(Assets.imgTopLeft),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(Assets.imgTopRight),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(Assets.imgBottomRight),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SvgPicture.asset(Assets.imgBottomLeft),
          ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(Assets.imgLoginLogo),
          )
        ],
      ),
    );
  }
}
