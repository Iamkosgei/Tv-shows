import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tv_shows/configs/assets.dart';
import 'package:flutter_tv_shows/configs/colors.dart';
import 'package:flutter_tv_shows/utils/extensions.dart';

class ErrorRetryView extends StatelessWidget {
  final String error;
  final VoidCallback onTapRetry;

  const ErrorRetryView(
      {Key? key, required this.error, required this.onTapRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(Assets.errorImg),
        ),
        Text(
          error,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 32.0,
        ),
        ElevatedButton(
          onPressed: onTapRetry,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all(
                primaryColor,
              ),
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              )),
          child: Text('${context.loc?.retry}'),
        )
      ],
    );
  }
}
