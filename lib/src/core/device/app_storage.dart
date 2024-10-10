import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum AppSecureStorageKeys { sessionToken }

class AppSecureStorage {
  final FlutterSecureStorage _storage;

  AppSecureStorage({required FlutterSecureStorage storage})
      : _storage = storage;

  Future<String?> getSessionToken() {
    return _storage.read(key: AppSecureStorageKeys.sessionToken.name);
  }

  Future<void> setSessionToken(String token) {
    return _storage.write(
      key: AppSecureStorageKeys.sessionToken.name,
      value: token,
    );
  }

  Future<void> deleteSessionToken() {
    return _storage.delete(key: AppSecureStorageKeys.sessionToken.name);
  }
}
