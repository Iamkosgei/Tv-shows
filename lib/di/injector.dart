import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tv_shows/data/local_data/secure_storage_helper.dart';
import 'package:get_it/get_it.dart';

GetIt inject = GetIt.instance;

Future<void> setUpLocator() async {
  inject.registerSingleton<SecureStorageHelper>(
    SecureStorageHelperImpl(
      flutterSecureStorage: const FlutterSecureStorage(),
    ),
  );
}
