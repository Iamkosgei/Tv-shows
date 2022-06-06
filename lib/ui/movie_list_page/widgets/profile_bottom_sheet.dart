import 'package:flutter/material.dart';
import 'package:flutter_tv_shows/configs/colors.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:flutter_tv_shows/di/injector.dart';
import 'package:flutter_tv_shows/navigation/pages.dart';
import 'package:flutter_tv_shows/services/navigation_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: MediaQuery.of(context).viewInsets,
      margin: const EdgeInsets.all(8),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context)?.logOut}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  //TODO refactor
                  inject.get<NavigationService>().goBack();
                  inject.get<SecureStorageHelper>().clearAll();
                  inject.get<NavigationService>().navigateTo(loginPage);
                },
                child: Text('${AppLocalizations.of(context)?.retry}')),
          ],
        ),
      ),
    );
  }
}
