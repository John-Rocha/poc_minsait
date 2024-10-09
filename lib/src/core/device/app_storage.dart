import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class AppStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

class AppStorageImpl implements AppStorage {
  final FlutterSecureStorage _secureStorage;

  AppStorageImpl({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  @override
  Future<void> write(String key, String value) {
    return _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) {
    return _secureStorage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _secureStorage.deleteAll();
  }
}
