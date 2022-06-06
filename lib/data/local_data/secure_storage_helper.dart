import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageHelper {
  Future<String?> getString(String key);
  Future<void> setString(String key, String value);
  Future<void> clearAll();
}

class SecureStorageHelperImpl implements SecureStorageHelper {
  final FlutterSecureStorage flutterSecureStorage;

  SecureStorageHelperImpl({required this.flutterSecureStorage});
  @override
  Future<String?> getString(String key) async {
    final savedStr = await flutterSecureStorage.read(key: key);
    return savedStr;
  }

  @override
  Future<void> setString(String key, String value) async {
    return await flutterSecureStorage.write(key: key, value: value);
  }

  @override
  Future<void> clearAll() async {
    return await flutterSecureStorage.deleteAll();
  }
}
