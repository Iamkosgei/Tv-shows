import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageHelper {
  Future<String?> getString(String key);
}

class SecureStorageHelperImpl implements SecureStorageHelper {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorageHelperImpl({required this.flutterSecureStorage});
  @override
  Future<String?> getString(String key) async {
    final savedStr = await flutterSecureStorage.read(key: key);
    return savedStr;
  }
}
